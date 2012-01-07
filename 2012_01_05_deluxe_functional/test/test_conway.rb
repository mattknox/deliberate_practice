require "rubygems"
require "test/unit"

LIVE = lambda { |cell, neighbor_count, live_cells|
  cell if neighbor_count == 3 || ( neighbor_count == 2 && live_cells.member?(cell))
}

NEIGHBORS = lambda { |cell| [[-1, -1], [-1, 0], [-1, 1],
                             [0, -1], [0, 1],
                             [1, -1], [1, 0], [1, 1]].map { |x, y|
    [cell.first + x, cell.last + y]} }

def make_evolver(live_f = LIVE, neighbor_f = NEIGHBORS)
  def evolve(live_f, neighbor_f, live_cells)
    neighbor_counts = Hash.new(0)

    live_cells.each do |cell|
      neighbor_f.call(cell).each do |c|
        neighbor_counts[c] += 1
      end
    end

    neighbor_counts.map { |k, v| live_f.call(k, v, live_cells)}.compact.sort
  end

  lambda { |live_cells| evolve(live_f, neighbor_f, live_cells) }
end

class ConwayTest < Test::Unit::TestCase
  def setup
    @evolver = make_evolver
  end

  SQUARE = [[1, 1], [1, 2], [2, 1], [2, 2]]
  LONELY = [[1, 1]]
  H_SEMAPHORE = [[1, 1], [1, 2], [1, 3]]
  V_SEMAPHORE = [[0, 2], [1, 2], [2, 2]]

  def test_empty_board
    assert_equal [], @evolver.call([])
  end

  def test_lonely_board
    assert_equal [], @evolver.call([[1,1]])
  end
  def test_square
    assert_equal SQUARE, @evolver.call(SQUARE)
  end

  def test_semaphore
    assert_equal H_SEMAPHORE, @evolver.call(V_SEMAPHORE)
    assert_equal V_SEMAPHORE, @evolver .call(H_SEMAPHORE)
  end
end
