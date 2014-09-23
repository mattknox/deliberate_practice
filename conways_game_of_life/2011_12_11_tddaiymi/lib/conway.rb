class Cell
  attr_accessor :live, :neighbors

  def initialize(live, neighbors)
    @live = live
    @neighbors = neighbors
  end

  def will_be_live?
    (live && neighbors > 1 && neighbors < 4) || neighbors == 3
  end
end
