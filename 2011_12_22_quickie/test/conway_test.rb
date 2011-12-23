require "rubygems"
require "test/unit"
require "#{File.dirname(__FILE__)}/../lib/conway"

class GameOfLifeTest < Test::Unit::TestCase
  BLANK_LINE = (("." * 10) + "\n")
  EMPTY_BOARD = BLANK_LINE * 10
  LONELY_BOARD = BLANK_LINE + "..#.......\n" + (BLANK_LINE * 8)
  SQUARE_BOARD = BLANK_LINE + ("..##......\n" * 2) + (BLANK_LINE * 7)

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
  end
end
