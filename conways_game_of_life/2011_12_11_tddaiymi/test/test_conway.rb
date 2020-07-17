require "rubygems"
require "test/unit"
require "#{File.dirname(__FILE__)}/../lib/conway"

class TestConway < Test::Unit::TestCase
  def test_lonely_cell_dies
    neighbor_range = 0..1
    live = true
    neighbor_range.each do |neighbors|
      assert !Cell.new(live, neighbors).will_be_live?
    end
  end

  def test_live_cell_with_enough_neighbors_lives
    neighbor_range = 2..3
    live = true

    neighbor_range.each do |neighbors|
      assert Cell.new(live, neighbors).will_be_live?
    end
  end

  def test_live_overcrowded_cell_dies
    neighbor_range = 4..8
    live = true

    neighbor_range.each do |neighbors|
      assert !Cell.new(live, neighbors).will_be_live?
    end
  end

  def test_dead_cell_with_three_neighbors_lives
    live = false
    neighbors = 3
    assert Cell.new(live, neighbors).will_be_live?
  end

  def test_dead_cell_with_neighbors_other_than_three_stays_dead
    live = false
    neighbor_range = (0..2).to_a + (4..8).to_a

    neighbor_range.each do |neighbors|
      assert !Cell.new(live, neighbors).will_be_live?
    end
  end
end
