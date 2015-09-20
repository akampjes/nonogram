class GenerateCluesOnPuzzle
  def initialize(puzzle:)
    @puzzle = puzzle
  end

  def call
    board = Board.new(size: @puzzle.board_size)

    board.randomly_populate!

    create_clues!(lines: board.row_lines, orientation: :row)
    create_clues!(lines: board.column_lines, orientation: :column)
  end

  private

  def create_clues!(lines:, orientation:)
    lines.each_with_index do |line, index|
      legend = CalculateLegend.new(line: line).call

      clue = @puzzle.clues.new(position: index, orientation: orientation, legend: legend)
      clue.save!
    end
  end
end
