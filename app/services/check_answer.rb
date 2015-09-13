class CheckAnswer
  def initialize(puzzle:, grid:)
    @puzzle = puzzle
    @grid = grid
  end

  def call
    all_clues_correct?
  end

  private

  def all_clues_correct?
    lines_correct?(@puzzle.row_clues, @grid) &&
      lines_correct?(@puzzle.column_clues, @grid.transpose)
  end

  def lines_correct?(clues, grid)
    clues.each do |clue|
      return false unless line_correct?(clue, grid[clue.position])
    end

    true
  end

  def line_correct?(clue, line)
    clue.lengths == CalculateLengths.new(line: line).call
  end
end
