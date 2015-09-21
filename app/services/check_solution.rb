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
    lines_correct?(@puzzle.legends.for_rows, @board.row_lines) &&
      lines_correct?(@puzzle.legends.for_columns, @board.column_lines)
  end

  def lines_correct?(legends, board_lines)
    legends.all? do |legend|
      line_correct?(legend, board_lines[legend.position])
    end
  end

  def line_correct?(legend, line)
    legend.clues == CalculateLegend.new(line: line).call
  end
end
