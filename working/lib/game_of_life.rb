class ConwayGame
  attr_accessor :live_cells

  DEFAULT_WIDTH  = 10
  DEFAULT_HEIGHT = 10

  def initialize
    @live_cells = []
  end

  def evolve
    live_neighbors = Hash.new(0)
    next_gen = []
    @live_cells.each do |c|
      c.neighbor_coords.each do |coord|
        live_neighbors[coord] += 1
      end
    end

    @live_cells.each do |c|
      next_gen << c if [2].member?(live_neighbors[c.coords])
    end

    live_neighbors.each do |k, v|
      if v == 3
        next_gen << Cell.new(k)
      end
    end

    @live_cells = next_gen
  end

  def board_state
    (0..9).map do |y|
      (0..9).map do |x|
        live_cells.member?(Cell.new([x, y])) ? "#" : "."
      end.join("")
    end.join("\n") + "\n"
  end

  def board_state=(state)
    @live_cells = []
    state_array = state.split("\n").map { |x| x.split("") }
    state_array.each_with_index do |row, y|
      row.each_with_index do |elt, x|
        @live_cells << Cell.new([x, y]) if elt == "#"
      end
    end
  end
end

class Cell
  attr_accessor :coords

  def initialize(coords)
    @coords = coords
  end

  def ==(other)
    other.coords == self.coords
  end

  def neighbor_coords
    [[-1, -1], [-1, 0], [-1, 1],
     [0, -1], [0, 1],
     [1, -1], [1, 0], [1, 1]].map { |x, y| [x + coords.first, y + coords.last]}
  end
end
