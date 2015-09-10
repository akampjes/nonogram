require "#{Rails.root}/lib/array"

class Grid
  attr_reader :grid

  def initialize(size:)
    @grid = Array.new(size) { Array.new(size) }
  end

  def from_answer(answer)
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

  # Crappy method for debugging/testing things
  def display_string(game)
    column_clues = []
    game.column_clues.each do |clue|
      column_clues << clue.values.lfill(4, nil)
    end

    row_clues = []
    game.row_clues.each do |clue|
      row_clues << clue.values.lfill(4, nil)
    end

    result = ''

    # First add all the clues for the columns
    n = column_clues[0].length
    for i in 0..n-1
      result << (' '*n).to_s
      column_clues.each do |row|
        result << (row[i] || ' ').to_s
      end
      result << "\n"
    end

    for i in board_range
      # Next add all the clues for the rows
      row_clues[i].each do |clue|
        result << (clue || ' ').to_s
      end

      # And also actual grid values
      for j in board_range
        if @grid[i][j]
          result << 'x'
        else
          result << '_'
        end
      end
      result << "\n"
    end

    result
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
