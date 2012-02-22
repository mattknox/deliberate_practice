require "rubygems"
require "test/unit"
class PalindromeTest < Test::Unit::TestCase
  def expand_from_center(str, top, bottom)
    # return the max length you can get to given a top/bottom
    while(bottom >= 0 && top < str.length) do
      break if str[bottom] != str[top]
      bottom -= 1
      top += 1
    end
    # top and bottom are one char too far away from center, and if they are ==,
    # then we want length 1
    return top - bottom - 1
  end

  def find_longest_palindrome(str)
    max_length = 0
    longest_pal = ""

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
        start = i - even / 2 + 1
        longest_pal = str[start, even ]
      end
    end
    longest_pal
  end

  def test_palindrome
    assert_equal "", find_longest_palindrome("")
    assert_equal "a", find_longest_palindrome("abc")
    assert_equal "c", find_longest_palindrome("cba")
    assert_equal "aa", find_longest_palindrome("aa")
    assert_equal "aa", find_longest_palindrome("aabb")
    assert_equal "aa", find_longest_palindrome("aabbcc")
    assert_equal "racecar", find_longest_palindrome("racecar")
    assert_equal "racecar", find_longest_palindrome("I have a racecar.")
    assert_equal "ooooooooooo", find_longest_palindrome("I have a racecar.bxoooooooooooaxb")
    assert_equal "bxoooooooooooxb", find_longest_palindrome("I have a racecar.bxoooooooooooxb")
    # assert_equal "", find_longest_palindrome()
  end
end
