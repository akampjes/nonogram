class GenerateNewPuzzle
  def initialize(puzzle:)
    @puzzle = puzzle
  end

  def call
    grid = Grid.new(size: @puzzle.board_size).grid

    grid = randomly_populate(grid)

    create_clues!(grid: grid, orientation: :row)
    create_clues!(grid: grid.transpose, orientation: :column)
  end

  private

  def create_clues!(grid:, orientation:)
    grid.each_with_index do |line, index|
      clue = @puzzle.clues.new(position: index, orientation: orientation)

      clue.lengths = CalculateLengths.new(line: line).call
      clue.save!
    end
  end

  def randomly_populate(grid)
    grid.map do |columns|
      columns.map do |tile|
        random_square
      end
    end
  end

  def random_square
    # About 50% chance of dark square seems to generate alright puzzles
    rand < 0.5 ? true : false
  end
end
