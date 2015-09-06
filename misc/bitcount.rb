# this is intended to count the number of bits in a given bitvector
# as fast as possible.

# naive approach:
# first find the maximum bit set by taking a logarithm.
# then add up the 1 bits

def max_bit(bignum)
  return 0 if bignum == 0
  Math.log2(bignum).floor
end

def bit_at(bignum, x)
  (bignum & (2 ** x)) / 2 ** x
end

def ones_old(bignum)
  max = max_bit(bignum)
  count = 0
  (max + 1).times {|x| count += bit_at(bignum, x) }
  count
end

def ones(n)
  max = max_bit(n)
  count = 0
  (0..max).each {|i| count += n[i]}
  count
end

def bitcount_table(max_size)
  # this builds an array of counts of set bits, so arr[n] has the
  # number of 1 bits in n
  arr = [0]
  while arr.size < max_size
    arr.each_with_index do |x, i|
      break if i > max_size
      arr[i * 2] = x
      arr[i + 1] = x + 1 if i.even?
    end
  end
  arr.first max_size
end

def bitcount_in_chunks(bignum)
  maxbit = max_bit bignum
  count = 0
  ((maxbit+29)/30).times do |offset|
    x = (bignum >> (offset*30)) & 0x3fffffff
    x = x - ((x >> 1) & 0x55555555)
    x = (x & 0x33333333) + ((x >> 2) & 0x33333333)
    x = (x + (x >> 4)) & 0x0f0f0f0f
    x = x + (x >> 8)
    x = x + (x >> 16)
    count += x & 0x3f
  end
  count
end

def bitcount_in_chunks2(bignum, table)
  maxbit = max_bit bignum
  count = 0
  ((maxbit+15)/16).times do |offset|
    x = (bignum>> (offset*16)) & 0xffff
    count += table[x]
  end
  count
end

def bitcount_in_chunks3(n, table, chunk_size)
  count = 0
  mask = (1 << chunk_size) - 1
  maxbit = max_bit n
  (maxbit/ chunk_size.to_f).ceil.times do |i|
    chunk = (n >>(i * chunk_size)) & mask
    count += table[chunk]
  end
end
# further benchmarking oddly shows that the naive version of ones is fastest. !?

# benchmark! tl:dr; unreadable hacker's delight method is fast and
# little memory, table lookup is slighly faster, going by bit is slow
# as hell.
#
# x = Kernel.rand(2 ** 1000); puts Benchmark.realtime {puts bitcount_in_chunks(x)}; puts Benchmark.realtime {puts bitcount_in_chunks2(x, table)}; puts Benchmark.realtime { puts ones(x)}
# 505
# 0.000242233276367188
# 505
# 0.000239133834838867
# 505
# 0.00765395164489746
