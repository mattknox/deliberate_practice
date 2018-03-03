def prime?(n)
  raise ArgumentError if n < 1
  return false if n == 1
  return true if n == 2
  return false if 0 == n % 2
  stop = Math.sqrt(n).ceil
  div = 3 # next thing to divide by.
  while div <= stop
    return false if 0 == n % div
    div += 2
  end
  return true
end

# gives you the longest run of nonprimes in the first million integers.
(1..1000000).chunk {|x| prime? x }.map {|a| a.last.size }.max

# run-length encoding
"1 1 1 1 1 1 1 1 2 2 3 1 1 1 ".split.chunk {|x| x}.map {|(x, a)| *[x.to_i, a.size] }
