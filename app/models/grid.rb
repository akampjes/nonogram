class Grid
  def initialize(size:)
    @grid = Array.new(size) { Array.new(size) }
  end

  def rows
    @grid
  end

  def columns
    @grid.transpose
  end

  def from_selected_tiles(answer)
    return self if answer.blank?
    answer.each do |tile|
      row = tile[:row]
      column = tile[:column]
      @grid[row.to_i][column.to_i] = true
    end
    self
  end

  def randomly_populate!
    @grid.map! do |columns|
      columns.map do |tile|
        random_square
      end
    end

    self
  end

  private

  def random_square
    # About 50% chance of dark square seems to generate alright puzzles
    rand < 0.5 ? true : false
  end
end
