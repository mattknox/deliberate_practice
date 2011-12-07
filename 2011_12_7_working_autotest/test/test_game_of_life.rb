require "rubygems"
require "test/unit"
require "#{File.dirname(__FILE__)}/../lib/game_of_life"

class GameOfLifeTest < Test::Unit::TestCase
  BLANK_LINE = "..........\n"
  EMPTY_BOARD = BLANK_LINE * 10
  LONELY_BOARD = BLANK_LINE + "..#.......\n" + (BLANK_LINE * 8)
  SQUARE_BOARD = BLANK_LINE + ("..##......\n" * 2) + (BLANK_LINE * 7)
  SEMAPHORE_H  = (BLANK_LINE * 2) + "..###.....\n" + (BLANK_LINE * 7)
  SEMAPHORE_V  = BLANK_LINE + ("...#......\n" * 3) + (BLANK_LINE * 6)

  def setup
    @g = Game.new
  end

  def test_board_starts_empty
    assert_equal @g.live_cells, []
  end

  def test_empty_board_display
    assert_equal @g.inspect, EMPTY_BOARD
  end

  def test_evolve_from_empty_to_empty
    @g.evolve
    assert_equal @g.live_cells, []
  end

  def test_set_cell
    @g.set_cell [2, 1]
    assert_equal @g.live_cells.length, 1
    assert_equal @g.inspect, LONELY_BOARD
  end

  def test_evolve_from_lonely_to_empty
    @g.set_cell [2, 1]
    @g.evolve
    assert_equal @g.inspect, EMPTY_BOARD
  end

  def test_square_board_is_static
    @g.set_cell [2,1]
    @g.set_cell [3,1]
    @g.set_cell [2,2]
    @g.set_cell [3,2]
    assert_equal @g.inspect, SQUARE_BOARD
    @g.evolve
    assert_equal @g.inspect, SQUARE_BOARD
  end

  def test_semaphore
    @g.set_cell [2,2]
    @g.set_cell [3,2]
    @g.set_cell [4,2]
    assert_equal @g.inspect, SEMAPHORE_H
    @g.evolve
    assert_equal @g.inspect, SEMAPHORE_V
    @g.evolve
    assert_equal @g.inspect, SEMAPHORE_H
  end
end
