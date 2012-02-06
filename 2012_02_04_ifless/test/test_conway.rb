require "rubygems"
require "test/unit"

class Conway
  def evolve(live_cells)
    neighbor_count = Hash.new(0)
    live_cells.each do |center|
      neighbors(center).each do |c|
        neighbor_count[c] += 1
      end
    end
    neighbor_count.map {|k, v| live?(v, live_cells.member?(k)) && k}.compact.sort
  end

  def live?(count, is_live?)
    (count == 3 || (count == 2 && is_live?))
  end

  def neighbors(center)
    [[-1, -1], [-1, 0], [-1, 1],
     [0, -1], [0, 1],
     [1, -1], [1, 0], [1, 1]].map { |x, y| [center[0] + x, center[1] + y]}
  end
end

class ConwayTest < Test::Unit::TestCase
  SQUARE = [[1, 1], [1, 2], [2, 1], [2, 2]]

  def setup
    @game = Conway.new
  end

  def test_empty_board
    assert_equal [], @game.evolve([])
  end

  def test_square_board_is_stable
    assert_equal SQUARE, @game.evolve(SQUARE)
  end

  def test_lonely_board_dies
    assert_equal [], @game.evolve([[1, 1]])
  end
end
