require "rubygems"
require "test/unit"

IS_LIVE = lambda { |cell, neighbor_count, live_cells|
  cell if neighbor_count == 3 || ( neighbor_count == 2 && live_cells.member?(cell))
}

GET_NEIGHBORS = lambda { |cell| [[-1, -1], [-1, 0], [-1, 1],
                             [0, -1], [0, 1],
                             [1, -1], [1, 0], [1, 1]].map { |x, y|
    [cell.first + x, cell.last + y]} }

def evolve(live_cells, get_neighbors = GET_NEIGHBORS, is_live = IS_LIVE)
  neighbor_counts = Hash.new(0)

  live_cells.each do |cell|
    get_neighbors.call(cell).each do |c|
      neighbor_counts[c] += 1
    end
  end

  neighbor_counts.map { |k, v| k if is_live.call(k, v, live_cells)}.compact.sort
end

class ConwayTest < Test::Unit::TestCase
  SQUARE = [[1, 1], [1, 2], [2, 1], [2, 2]]
  LONELY = [[1, 1]]
  H_SEMAPHORE = [[1, 1], [1, 2], [1, 3]]
  V_SEMAPHORE = [[0, 2], [1, 2], [2, 2]]

  def test_empty_board_is_stable
    assert_equal [], evolve([])
  end

  def test_square_board_is_stable
    assert_equal SQUARE, evolve(SQUARE)
  end

  def test_lonely_board_dies
    assert_equal [], evolve(LONELY)
  end
end
