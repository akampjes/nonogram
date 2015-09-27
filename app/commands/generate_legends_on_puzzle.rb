class GenerateLegendsOnPuzzle
  def initialize(puzzle:)
    @puzzle = puzzle
  end

  def call
    board = Board.new(size: @puzzle.board_size, colors: @puzzle.max_colors)

    RandomlyPopulateBoard.new(board: board, max_colors: @puzzle.max_colors).call

    create_legends!(board.row_lines, :row)
    create_legends!(board.column_lines, :column)
  end

  private

  def create_legends!(lines, orientation)
    lines.each_with_index do |line, legend_position|
      legend = @puzzle.legends.new(position: legend_position, orientation: orientation)

      create_clues!(line,legend)
    end
  end

  def create_clues!(line, legend)
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
