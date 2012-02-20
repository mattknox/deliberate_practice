def expand_from_center(str, top, bottom)
  # return the max length you can get to given a top/bottom
  while(bottom >= 0 && top < str.length) do
    break if str[bottom] != str[top]
    bottom -= 1
    top += 1
  end
  return top - bottom - 1 # explain this.
end

def find_longest_palindrome(str)
  max_length = 0
  longest_pal = nil

  (0...str.length).each do |i|
    odd  = expand_from_center str, i, i
    if odd > max_length
      max_length = odd
      start = i - odd / 2 # ruby truncates
      longest_pal = str[start, odd ]
    end
    even = expand_from_center str, i, i + 1
    if even > max_length
      max_length = even
      start = i - even / 2
      longest_pal = str[start, even ]
    end
  end
  longest_pal
end
