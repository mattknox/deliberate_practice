require "rubygems"
require "test/unit"
require "#{File.dirname(__FILE__)}/../lib/poker_scorer"

class PokerScorerTest < Test::Unit::TestCase
  def test_examples
    assert_equal PokerScorer.pokerHandRanking(["10h", "Jh", "Qh", "Ah", "Kh"]), "Royal Flush"

    assert_equal PokerScorer.pokerHandRanking(["3h", "5h", "Qs", "9h", "Ad"]), "High Card"

    assert_equal PokerScorer.pokerHandRanking(["10s", "10c", "8d", "10d", "10h"]), "Four of a Kind"
  end
end
