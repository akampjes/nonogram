class Grid
  attr_reader :grid

  def initialize(size:)
    @grid = Array.new(size) { Array.new(size) }
  end

  def from_answer(answer)
    return self if answer.blank?
    answer.each do |tile|
      row = tile[:row]
      column = tile[:column]
      @grid[row][column] = true
    end
    self
  end

  def randomly_populate!
    for i in board_range
      for j in board_range
        @grid[i][j] = random_square
      end
    end

    @grid
  end
  private

  def random_square
    # About 50% chance of dark square seems to generate alright boards
    rand < 0.5 ? true : false
  end

  def board_range
    0..(@grid.length - 1)
  end
end
