require "rubygems"
require "test/unit"
require "#{File.dirname(__FILE__)}/../lib/conway"

class ConwayTest < Test::Unit::TestCase
  SQUARE_BOARD = [[1, 1], [1, 2], [2, 1], [2, 2]]
  def setup
    @game = Game.new
  end

  def test_state_starts_empty
    assert_equal [], @game.state
  end

  def test_set_cells
    @game.set_cells([1, 1])
    assert_equal [[1,1]], @game.state
  end

  def test_empty_state_stays_empty
    assert_equal [], @game.state
    @game.evolve
    assert_equal [], @game.state
  end

  def test_square_board_is_stable
    assert_equal [], @game.state
    @game.set_cells(*SQUARE_BOARD)
    assert_equal SQUARE_BOARD, @game.state
    @game.evolve
    assert_equal SQUARE_BOARD, @game.state
  end

  def test_lonely_board_dies
    @game.set_cells([1,1])
    @game.evolve
    assert_equal [], @game.state
  end

  def test_semaphore
    @game.set_cells([1, 1], [2, 1], [3, 1])
    @game.evolve
    assert_equal [[2, 0], [2, 1], [2, 2]], @game.state
  end
end
