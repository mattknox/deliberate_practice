# Given the mapping a = 1, b = 2, ... z = 26, and an encoded message, count the number of ways it can be decoded.

# For example, the message '111' would give 3, since it could be decoded as 'aaa, 'ka', and 'ak'.

require "test/unit"
class CountEncodingTest < Test::Unit
  def encodings(str)
    Enumerator.new do |y|

    end
  end


  def count_encodings(str)
  end

  def test_count_encodings
    assert_equal encodings(111).sort, ["aaa", "ak", "ka"]
  end
end

def step_distance(distance, step_lengths, step_history = nil)
  invalid_starters = []
  step_history ||= [step_lengths.first] * (distance.to_f / step_lengths.first).ceil
  Enumerator.new do |y|
  end
end
