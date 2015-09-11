class CheckAnswer
  def initialize(game:, grid:)
    @game = game
    @grid = grid
  end

  def call
    all_clues_correct?
  end

  private

  def all_clues_correct?
    check_clue_lines(@game.row_clues, @grid) &&
      check_clue_lines(@game.column_clues, @grid.transpose)
  end

  def check_clue_lines(clues, grid)
    clues.each do |clue|
      return false unless line_correct?(clue, grid[clue.position])
    end

    true
  end

  def line_correct?(clue, line)
    clue.lengths == CalculateLengths.new(line: line).call
  end
end
