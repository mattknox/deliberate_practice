require "rubygems"
require "test/unit"
require "game_of_life"

class GameOfLifeTest < Test::Unit::TestCase
  BLANK_LINE = (("." * ConwayGame::DEFAULT_WIDTH) + "\n")

  EMPTY_BOARD = BLANK_LINE * ConwayGame::DEFAULT_HEIGHT
  SQUARE_BOARD = (BLANK_LINE * 2) + "..##......\n..##......\n" + (BLANK_LINE * 6)
  LONELY_BOARD = (BLANK_LINE * 2) + "...#......\n..........\n" + (BLANK_LINE * 6)
  SEMAPHORE_V_BOARD = BLANK_LINE + "...#......\n...#......\n...#......\n" + (BLANK_LINE * 6)
  SEMAPHORE_H_BOARD = (BLANK_LINE * 2) + "..###.....\n..........\n" + (BLANK_LINE * 6)

  def setup
    @g = ConwayGame.new
  end

  def test_board_has_live_cells
    assert_equal @g.live_cells, []
  end

  def test_evolution
    assert_equal @g.live_cells, []
    assert_nothing_raised { @g.evolve }
    assert_equal @g.live_cells, []
  end

  def test_board_state
    blank_state = EMPTY_BOARD
    assert_equal @g.board_state, blank_state
  end

  def test_set_board_state
    @g.board_state= SQUARE_BOARD
    assert_equal @g.board_state, SQUARE_BOARD
  end

  def test_lonely_board_dies
    @g.board_state= LONELY_BOARD
    assert_equal @g.board_state, LONELY_BOARD
    @g.evolve
    assert_equal @g.board_state, EMPTY_BOARD
  end

  def test_square_board_is_static
    @g.board_state= SQUARE_BOARD
    assert_equal @g.board_state, SQUARE_BOARD
    @g.evolve
    assert_equal @g.board_state, SQUARE_BOARD
  end

  def test_live_cells
    @g.board_state= LONELY_BOARD
    assert_equal @g.live_cells, [Cell.new([3, 2])]
  end

  def test_semaphore
    @g.board_state = SEMAPHORE_H_BOARD
    @g.evolve
    assert_equal @g.board_state, SEMAPHORE_V_BOARD
    @g.evolve
    assert_equal @g.board_state, SEMAPHORE_H_BOARD
  end
end

puts "***************#{Time.now}****************"
