require "rubygems"
require "test/unit"
require "#{File.dirname(__FILE__)}/../lib/conway"

class GameOfLifeTest < Test::Unit::TestCase
  BLANK_LINE = (("." * 10) + "\n")
  EMPTY_BOARD = BLANK_LINE * 10
  LONELY_BOARD = BLANK_LINE + "..#.......\n" + (BLANK_LINE * 8)
  SQUARE_BOARD = BLANK_LINE + ("..##......\n" * 2) + (BLANK_LINE * 7)
  SEMAPHORE_H_BOARD = (BLANK_LINE * 2) + "..###.....\n" + (BLANK_LINE * 7)
  SEMAPHORE_V_BOARD = BLANK_LINE + ("...#......\n" * 3) + (BLANK_LINE * 6)

  def setup
    @game = ConwayGame.new
  end

  def test_state
    assert_equal @game.state, EMPTY_BOARD
  end

  def test_evolve
    assert_equal @game.state, EMPTY_BOARD
    @game.evolve
    assert_equal @game.state, EMPTY_BOARD
  end

  def test_lonely_board_dies
    @game.set_cells([1, 2])
    @game.evolve
    assert_equal @game.state, EMPTY_BOARD
  end

  def test_square_board_lives
    @game.set_cells([2, 1], [2, 2], [3, 1], [3, 2] )
    assert_equal @game.state, SQUARE_BOARD
    @game.evolve
    assert_equal @game.state, SQUARE_BOARD
  end

  def test_semaphore
    @game.set_cells([2, 2], [3, 2], [4, 2])
    assert_equal @game.state, SEMAPHORE_H_BOARD
    @game.evolve
    assert_equal @game.state, SEMAPHORE_V_BOARD
  end
end
