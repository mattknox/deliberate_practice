require "rubygems"
require "test/unit"
require "#{File.dirname(__FILE__)}/../lib/conway"

class TestConway < Test::Unit::TestCase
  BLANK_LINE  = "." * 10 + "\n"
  EMPTY_BOARD = BLANK_LINE * 10
  SQUARE_BOARD = (BLANK_LINE * 2) + ("..##......\n" * 2) + (BLANK_LINE * 6)
  LONELY_BOARD = BLANK_LINE + "..#.......\n" + (BLANK_LINE * 8)
  def setup
    @game = Game.new
  end

  def test_game_is_empty_by_default
    assert_equal EMPTY_BOARD, @game.display
  end

  def test_cells_can_be_set
    @game.set_cells([2,2],[3,2],[2,3],[3,3])
    assert_equal @game.display, SQUARE_BOARD
  end

  def test_evolve_square_board_is_stable
    @game.set_cells([2,2],[3,2],[2,3],[3,3])
    assert_equal @game.display, SQUARE_BOARD
    @game.evolve
    assert_equal @game.display, SQUARE_BOARD
  end

  def test_lonely_board_dies
    @game.set_cells([2, 1])
    assert_equal @game.display, LONELY_BOARD
    @game.evolve
    assert_equal @game.display, EMPTY_BOARD
  end
end
