require 'rubygems'
require 'exemplor'

BLANK_LINE = ("." * 10) + "\n"
EMPTY_BOARD = BLANK_LINE * 10
LONELY_BOARD = "..#.......\n" + (BLANK_LINE * 9)
SQUARE_BOARD = BLANK_LINE + (".##.......\n" * 2) + (BLANK_LINE * 7)

class ConwayGame
  attr_accessor :live_cells

  def initialize
    @live_cells = []
  end

  def board
    (0..9).map do |y|
      (0..9).map do |x|
        @live_cells.member?([x, y]) ? "#" : "."
      end.join("")
    end.join("\n") + "\n"
  end

  def neighbors(cell)
    ([-1, 0, 1].product([-1,0,1]) - [[0,0]]).map { |x, y|
      [x + cell.first, y + cell.last]}
  end

  def evolve
    neighbor_counts = Hash.new(0)
    @live_cells.map do |live_cell|
      neighbors(live_cell).map do |cell|
        neighbor_counts[cell] += 1
      end
    end
    next_gen = []

    neighbor_counts.each do |k, v|
      next_gen << k if 3 == v || (2 == v && @live_cells.member?(k))
    end

    @live_cells = next_gen
  end

  def set_cells(*cells)
    @live_cells += cells
  end
end

eg.setup do
  @game = ConwayGame.new
end

eg "board starts empty" do
  Assert(EMPTY_BOARD == @game.board)
end

eg "empty board stays empty" do
  Assert(EMPTY_BOARD == @game.board)
  @game.evolve
  Assert(EMPTY_BOARD == @game.board)
end

eg "set_cells" do
  @game.set_cells [2, 0]
  Assert(@game.board == LONELY_BOARD)
end

eg "lonely board dies" do
  @game.set_cells [2, 0]
  Assert(@game.board == LONELY_BOARD)
  @game.evolve
  Assert(@game.board == EMPTY_BOARD)
end

eg "square board lives" do
  @game.set_cells [1, 1], [2, 1], [1, 2], [2, 2]
  Assert(SQUARE_BOARD == @game.board)
  @game.evolve
  Assert(SQUARE_BOARD == @game.board)
end
