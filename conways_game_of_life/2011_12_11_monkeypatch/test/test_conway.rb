require "rubygems"
require "test/unit"

class Array
  def evolve
    neighbor_count = Hash.new(0)
    self.map do |cell|
      cell.neighbors.map do |seen|
        neighbor_count[seen] += 1
      end
    end

    neighbor_count.map do |cell, live_neighbors|
      cell if (live_neighbors == 2 && member?(cell)) || live_neighbors == 3
    end.compact.sort
  end

  def neighbors
    [[-1, -1], [-1, 0], [-1, 1],
     [0, -1], [0, 1],
     [1, -1], [1, 0], [1, 1]].map { |x,y| [first + x, last + y]}
  end
end

class TestConway < Test::Unit::TestCase
  EMPTY  = []
  LONELY = [[3,3]]
  SQUARE = [[2,2], [2,3], [3,2], [3,3]]
  HORIZ  = [[2,2], [3,2], [4,2]]
  VERT   = [[3,1], [3,2], [3,3]]

  def test_empty_board_stays_empty
    assert_equal EMPTY.evolve, EMPTY
  end

  def test_lonely_board_dies
    assert_equal LONELY.evolve, EMPTY
  end

  def test_square_board_stays
    assert_equal SQUARE.evolve, SQUARE
  end

  def test_semaphore
    assert_equal HORIZ.evolve, VERT
  end
end
