class GenerateCluesOnPuzzle
  def initialize(puzzle:)
    @puzzle = puzzle
  end

  def call
    board = Board.new(size: @puzzle.board_size)

    board.randomly_populate!

    create_legends!(lines: board.row_lines, orientation: :row)
    create_legends!(lines: board.column_lines, orientation: :column)
  end

  private

  def create_legends!(lines:, orientation:)
    lines.each_with_index do |line, index|
      clues = CalculateLegend.new(line: line).call

      legend = @puzzle.legends.new(position: index, orientation: orientation, clues: clues)
      legend.save!
    end
  end
end
