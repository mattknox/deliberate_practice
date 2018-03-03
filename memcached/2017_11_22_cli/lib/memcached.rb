require "socket"

class Memcached
  KEY  = /^[a-zA-Z_0-9]+$/
  SIZE = /^[1-9][0-9]*$/
  def initialize
    @store = {}
  end

  def parse(command_line)
    verb, *rest = command_line.split
    if verb == "get" && rest.size > 0 && rest.all? {|s| s.match(KEY) }
      [:get, rest]
    elsif verb == "set" &&
        rest.size == 2 &&
        rest.first.match(KEY) &&
        rest.last.match(SIZE)
      [:set, rest.first, rest.last.to_i]
    else
      raise ArgumentError.new("bad command #{command_line}")
    end
  end

  def get(key)
    if data = @store[key]
      "VALUE #{key} #{data.size}\n#{data}\nEND"
    else
      "END"
    end
  end

  def set(key, data)
    @store[key] = data
    "STORED"
  end

  def process_command(input, output)
    verb, keys, data_len = parse(input.gets)
    if :get == verb
      keys.map {|k| output.puts get(k) }
    elsif :set == verb
      data = input.read(data_len.succ).chomp # newline seperator
      raise ArgumentError.new("data_len:#{data_len} doesn't match '#{data}'") if data_len != data.size
      output.puts set(keys, data)
    else
      puts "bad command #{[verb, keys, data_len]}"
    end
    output.flush if output.respond_to? :flush
  end

  def serve(input = STDIN, output = STDOUT)
    while !input.eof? do
      process_command(input, output)
    end
  rescue Exception => e
    puts [e.class, e.message, e.backtrace].join("\n")
  end
end

class Runner
  def self.run(port)
    server = TCPServer.new port
    server.setsockopt(:SOCKET, :REUSEADDR, 1)
    memcache = Memcached.new
    loop do
      Thread.start(server.accept) do |client|
        memcache.serve client, client
      end
    end
  end
end

if __FILE__ == $0
  if ARGV[0]
    Runner.run(ARGV[0])
  else
    Memcached.new.serve
  end
end
