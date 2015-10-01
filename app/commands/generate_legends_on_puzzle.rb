class GenerateLegendsOnPuzzle
  def initialize(puzzle:, board:)
    @puzzle = puzzle
    @board = board
  end

  def call
    create_legends_and_clues(@board.rows, :row)
    create_legends_and_clues(@board.columns, :column)
  end

  private

  def create_legends_and_clues(lines, orientation)
    lines.each_with_index do |line, legend_position|
      legend = @puzzle.legends.new(position: legend_position, orientation: orientation)

      create_clues(line,legend)
    end
  end

  def create_clues(line, legend)
    clues = CalculateClues.new(line: line).call

    # Or I could do `ActiveRecord::Base.transaction`
    legend.transaction do
      clues.each do |clue|
        clue.legend = legend
        clue.save!
      end

      legend.save!
    end
  end
end
