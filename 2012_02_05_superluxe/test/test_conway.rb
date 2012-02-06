require "rubygems"
require "test/unit"

class Conway
  def initialize(survive = [2, 3], spawn = [3])
    @survive = survive
    @spawn   = spawn
  end

  def evolve(live_cells)
    counts = Hash.new(0)
    live_cells.each do |center|
      neighbors(center).map {|c| counts[c] += 1}
    end
    counts.keys.select {|k| live?(counts[k], live_cells.member?(k))}.sort
  end

  def neighbors(center)
    (([-1, 0, 1]).product([-1, 0, 1]) - [[0, 0]]).map {|x, y| [x + center.first, y + center.last]}
  end

  def live?(c, is_live)
    @spawn.member?(c) || (@survive.member?(c) && is_live)
  end
end

class ConwayTest < Test::Unit::TestCase
  SQUARE = ([1, 2]).product([1, 2])
  def setup
    @game = Conway.new
  end

  def test_empty_board_is_stable
    assert_equal [], @game.evolve([])
  end

  def test_square_board_is_stable
    assert_equal SQUARE, @game.evolve(SQUARE)
  end

  def test_lonely_board_dies
    assert_equal [], @game.evolve([[1,1]])
  end
end
