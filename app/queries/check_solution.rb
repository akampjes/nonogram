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
    solution_clues = CalculateClues.new(line: line).call

    return false if legend.clues.count != solution_clues.count

    legend.clues.ordered.zip(solution_clues).all? do |clue, solution_clue|
      # method this
      clue.color == solution_clue.color && clue.contiguous_boxes == solution_clue.contiguous_boxes
    end
  end
end
