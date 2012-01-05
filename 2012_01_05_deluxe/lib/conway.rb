class Game
  attr_accessor :live_cells, :topology

  def initialize(topology = Grid, rule = Rule)
    @live_cells = []
    @topology = topology
    @rule = rule
  end

  def set_cells(*cells)
    @live_cells += cells
  end

  def state
    live_cells.sort
  end

  def next_gen
    neighbor_counts = Hash.new(0)

    live_cells.each do |cell|
      topology.neighbors(cell).each do |c|
        neighbor_counts[c] += 1
      end
    end

    neighbor_counts.map { |k, v| @rule.live?(k, v, live_cells)}.compact
  end

  def evolve
    @live_cells = next_gen
  end
end

module Grid
  # this is the 2D topology typical in conway

  def self.neighbors(cell)
    [[-1, -1], [-1, 0], [-1, 1],
     [0, -1], [0, 1],
     [1, -1], [1, 0], [1, 1]].map { |x, y| [cell.first + x, cell.last + y]}
  end
end

module Rule
  def self.live?(cell, neighbor_count, live_cells)
    cell if neighbor_count == 3 || ( neighbor_count == 2 && live_cells.member?(cell))
  end
end
