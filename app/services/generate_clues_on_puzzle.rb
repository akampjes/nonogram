# Rename this to generatelegendsonpuzzle
class GenerateCluesOnPuzzle
  def initialize(puzzle:)
    @puzzle = puzzle
  end

  def call
    board = Board.new(size: @puzzle.board_size, colors: @puzzle.max_colors)

    board.randomly_populate!

    create_legends!(lines: board.row_lines, orientation: :row)
    create_legends!(lines: board.column_lines, orientation: :column)
  end

  private

  def create_legends!(lines:, orientation:)

    lines.each_with_index do |line, index|
      legend = @puzzle.legends.new(position: index, orientation: orientation)
      clues = CalculateLegend.new(line: line).call

      clues.each_with_index do |clue,index2|
        clue.position = index2
        clue.legend = legend
        #Clue.create!(position: index2, contiguous_boxes: clue, legend: legend)
        clue.save!
      end

      legend.save!
    end
  end
end
