class GenerateNewPuzzle
  def initialize(puzzle:)
    @puzzle = puzzle
  end

  def call
    grid = Grid.new(size: @puzzle.board_size)

    grid.randomly_populate!

    create_clues!(grid: grid.rows, orientation: :row)
    create_clues!(grid: grid.columns, orientation: :column)
  end

  private

  def create_clues!(grid:, orientation:)
    grid.each_with_index do |line, index|
      clue = @puzzle.clues.new(position: index, orientation: orientation)

      clue.lengths = CalculateLengths.new(line: line).call
      clue.save!
    end
  end
end
