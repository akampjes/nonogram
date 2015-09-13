class CheckAnswer
  def initialize(board:, grid:)
    @board = board
    @grid = grid
  end

  def call
    all_clues_correct?
  end

  private

  def all_clues_correct?
    check_clue_lines(@board.row_clues, @grid) &&
      check_clue_lines(@board.column_clues, @grid.transpose)
  end

  def check_clue_lines(clues, grid) # Rename to somehting something ?
    clues.each do |clue|
      return false unless line_correct?(clue, grid[clue.position])
    end

    true
  end

  def line_correct?(clue, line)
    clue.lengths == CalculateLengths.new(line: line).call
  end
end
