class Game
  attr_accessor :live_cells

  def initialize
    @live_cells = []
  end

  def display
    (0..9).map do |y|
      (0..9).map do |x|
        @live_cells.member?([x,y]) ? "#" : "."
      end.join("")
    end.join("\n") + "\n"
  end

  def set_cells(*list_of_coordinate_sets)
    list_of_coordinate_sets.each do |coords|
      live_cells << coords
    end
  end

  def evolve
    live_neighbors = Hash.new(0)
    next_gen = []
    @live_cells.each do |coords|
      neighbors(coords).each do |cell|
        live_neighbors[cell] += 1
      end
    end

    live_neighbors.each do |cell, count|
      next_gen << cell if 3 == count
      next_gen << cell if 2 == count && @live_cells.member?(cell)
    end

    @live_cells = next_gen
  end

  def neighbors(cell)
    [[-1, -1], [-1, 0], [-1, 1],
     [0, -1], [0, 1],
     [1, -1], [1, 0], [1, 1]].map { |x, y| [cell.first + x, cell.last + y] }
  end
end
