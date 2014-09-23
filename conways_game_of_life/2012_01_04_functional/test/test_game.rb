require "rubygems"
require "test/unit"
#require "#{File.dirname(__FILE__)}/../lib/game"

def to_string(live_cells)
  (0..9).map do |y|
    (0..9).map do |x|
      live_cells.member?([x, y]) ? "#" : "."
    end.join("")
  end.join("\n") + "\n"
end

def new_board
  []
end

def evolve(live_cells)
  next_gen = []
  neighbor_counts = Hash.new 0
  live_cells.each do |c|
    neighbors(c).each do |n|
      neighbor_counts[n] += 1
    end
  end

  neighbor_counts.each do |k, v|
    next_gen += k if v == 3 || (v == 2 && live_cells.member?(k))
  end
  next_gen
end

def neighbors(coords)
  ((-1..1).to_a.product((-1..1).to_a) - [[0, 0]]).map { |x, y| [coords.first + x, coords.last + y]}
end

class GameTest < Test::Unit::TestCase
  BLANK_LINE = "..........\n"
  EMPTY_BOARD = BLANK_LINE * 10
  def test_new_board
    assert_equal EMPTY_BOARD, to_string(new_board)
  end

  def test_empty_board_stays_empty
    assert_equal EMPTY_BOARD, to_string(evolve(new_board))
  end

  def test_lonely_board_dies
    assert_equal EMPTY_BOARD, to_string(evolve([[1, 1]]))
  end
end
