class Grid
  attr_reader :grid

  def initialize(size:)
    @grid = Array.new(size) { Array.new(size) }
  end

  def from_selected_tiles(answer)
    return self if answer.blank?
    answer.each do |tile|
      row = tile[:row]
      column = tile[:column]
      @grid[row][column] = true
    end
    self
  end
end
