def assert(val, needle, haystack)
  actual = index_of(needle, haystack)
  print actual == val ? "." : "failed: index_of('#{needle}', '#{haystack}') should return #{val}, got #{actual}\n"
end


def index_of(needle, haystack)
  for i in 0..(haystack.length - needle.length) do
    j = 0
    for j in 0...(needle.length) do
      break if (haystack[i + j] != needle[j])
    end
    return i if j == needle.length - 1
  end
  return -1
end

assert -1, "foo", "bar"
assert 0, "foo", "foo"
assert 3, "foo", "barfoo"
puts
