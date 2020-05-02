# In this challenge, you have to establish which kind of Poker combination is present in a deck of five cards. Every card is a string containing the card value (with the upper-case initial for face-cards) and the lower-case initial for suits, as in the examples below:
# "Ah" ➞ Ace of hearts
# "Ks" ➞ King of spades
# "3d" ➞ Three of diamonds
# "Qc" ➞ Queen of clubs
# here are 10 different combinations. Here's the list, in order of importance:

# Name  Description
# Royal Flush A, K, Q, J, 10, all with the same suit.
# Straight Flush  Five cards in sequence, all with the same suit.
# Four of a Kind  Four cards of the same rank.
# Full House  Three of a Kind with a Pair.
# Flush Any five cards of the same suit, not in sequence.
# Straight  Five cards in a sequence, but not of the same suit.
# Three of a Kind Three cards of the same rank.
# Two Pair  Two different Pair.
# Pair  Two cards of the same rank.
# High Card No other valid combination.
# Given an array hand containing five strings being the cards, implement a function that returns a string with the name of the highest combination obtained, accordingly to the table above.

# Examples
# pokerHandRanking(["10h", "Jh", "Qh", "Ah", "Kh"]) ➞ "Royal Flush"

# pokerHandRanking(["3h", "5h", "Qs", "9h", "Ad"]) ➞ "High Card"

# pokerHandRanking(["10s", "10c", "8d", "10d", "10h"]) ➞ "Four of a Kind"
require "set"
module PokerScorer
  RANKS = %w{A K Q J 10 9 8 7 6 5 4 3 2}
  def self.pokerHandRanking(hand) # represented as an array as above
    ranks = hand.inject(Hash.new(0)) {|m, x| m[x[0..-2]] += 1; m }
    is_flush = ::Set.new(hand.map {|x| x[-1] }).size == 1 # only one suit == flush
    is_straight = RANKS.each_cons(5).any? {|x| Set.new(x) == Set.new(ranks.keys)}
    if is_flush && is_straight and ranks["A"]
      "Royal Flush"
    elsif is_flush && is_straight
      "Straight Flush"
    elsif ranks.values.max == 4
      "Four of a Kind"
    elsif ranks.values.sort == [2, 3]
      "Full House"
    elsif is_flush
      "Flush"
    elsif is_straight
      "Straight"
    elsif ranks.values.max == 3
      "Three of a Kind"
    elsif ranks.values.sort == [1, 2, 2]
      "Two Pair"
    elsif ranks.values.max == 2
      "Pair"
    else
      "High Card"
    end
  end
end
