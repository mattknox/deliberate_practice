class ConwayGame
  attr_accessor :live_cells

  def initialize
    @live_cells = []
  end

  def set_cells(*cells)
    @live_cells += cells
  end

  def state
    (0..9).map do |y|
      (0..9).map do |x|
        live_cells.member?([x, y]) ? "#" : "."
      end.join("")
    end.join("\n") + "\n"
  end

  def evolve
    neighbor_count = Hash.new 0
    next_generation = []
    live_cells.each do |cell|
      neighbors(cell).each do |x|
        neighbor_count[x] += 1
      end
    end

    neighbor_count.each do |k, v|
      next_generation << k if 3 == v
      next_generation << k if 2 == v && live_cells.member?(k)
    end
  end

  def neighbors(cell)
    ([-1, 0, 1].product([-1,0,1]) - [[0,0]]).map { |x, y|
      [x + cell.first, y + cell.last]}
  end
end
