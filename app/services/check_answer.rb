class CheckAnswer
  def initialize(game:, grid:)
    @game = game
    @grid = grid
  end

  def call
    if all_clues_correct?
      true
    else
      false
    end
  end

  private

  def all_clues_correct?
    return false unless check_clue_lines(@game.row_clues, @grid)
    return false unless check_clue_lines(@game.column_clues, @grid.transpose)

    true
  end

  def check_clue_lines(clues, grid)
    clues.each do |clue|
      return false unless line_correct?(clue, grid[clue.position])
    end

    true
  end

  def line_correct?(clue, line)
    lengths = []

    run = 0
    line.each do |tile|
      if tile
        run += 1
      elsif run > 0
        lengths << run
        run = 0
      end
    end
    lengths << run if run > 0

    return false unless lengths == clue.lengths

    true
  end
end
