class CheckSolution
  def initialize(puzzle:, board:)
    @puzzle = puzzle
    @board = board
  end

  def call
    all_clues_correct?
  end

  private

  def all_clues_correct?
    lines_correct?(@puzzle.clues.for_rows, @board.row_lines) &&
      lines_correct?(@puzzle.clues.for_columns, @board.column_lines)
  end

  def lines_correct?(clues, board_lines)
    clues.all? do |clue|
      line_correct?(clue, board_lines[clue.position])
    end
  end

  def line_correct?(clue, line)
    clue.legend == CalculateLegend.new(line: line).call
  end
end
