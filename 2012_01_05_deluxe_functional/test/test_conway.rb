require "rubygems"
require "test/unit"

def evolve(live_cells)
  neighbor_counts = Hash.new(0)

  live_cells.each do |cell|
    neighbors(cell).each do |c|
      neighbor_counts[c] += 1
    end
  end

  neighbor_counts.map { |k, v| live?(k, v, live_cells)}.compact.sort
end

def live?(cell, neighbor_count, live_cells)
  cell if neighbor_count == 3 || ( neighbor_count == 2 && live_cells.member?(cell))
end

def neighbors(cell)
  [[-1, -1], [-1, 0], [-1, 1],
   [0, -1], [0, 1],
   [1, -1], [1, 0], [1, 1]].map { |x, y| [cell.first + x, cell.last + y]}
end

class ConwayTest < Test::Unit::TestCase
  SQUARE = [[1, 1], [1, 2], [2, 1], [2, 2]]
  LONELY = [[1, 1]]
  H_SEMAPHORE = [[1, 1], [1, 2], [1, 3]]
  V_SEMAPHORE = [[0, 2], [1, 2], [2, 2]]

  def test_empty_board
    assert_equal [], evolve([])
  end

  def test_lonely_board
    assert_equal [], evolve([[1,1]])
  end
  def test_square
    assert_equal SQUARE, evolve(SQUARE)
  end

  def test_semaphore
    assert_equal H_SEMAPHORE, evolve(V_SEMAPHORE)
    assert_equal V_SEMAPHORE, evolve(H_SEMAPHORE)
  end
end
