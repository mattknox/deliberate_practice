class Game
  attr_accessor :live_cells

  def initialize(topology = Grid2D)
    @live_cells = []
    @topology = topology.new
  end

  def evolve
    live_neighbor_count = Hash.new(0)

    @live_cells.map do |cell|
      @topology.neighbors(cell).each do |neighbor|
        live_neighbor_count[neighbor] += 1
      end
    end

    next_generation = []
    live_neighbor_count.map do |k,v|
      next_generation << k if 3 == v
      next_generation << k if 2 == v && @live_cells.member?(k)
    end
    @live_cells = next_generation
  end

  def inspect
    @topology.inspect(live_cells)
  end

  def set_cell(coords)
    @live_cells << coords
  end
end

class Grid2D
  def neighbors(c)
    [[-1, -1], [-1, 0], [-1, 1],
     [0, -1], [0, 1],
     [1, -1], [1, 0], [1, 1]].map { |x, y| [c.first + x, c.last + y]}
  end

  def inspect(live_cells)
    (0..9).map do |y|
      (0..9).map do |x|
        live_cells.member?([x,y]) ? "#" : "."
      end.join("")
    end.join("\n") + "\n"
  end
end
