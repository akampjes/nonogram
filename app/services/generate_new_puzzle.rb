class GenerateNewPuzzle
  def initialize(board:)
    @board = board
  end

  def call
    grid = Grid.new(size: @board.board_size)

    grid_array = grid.randomly_populate! # WRONG

    create_clues!(grid: grid_array, orientation: :row)
    create_clues!(grid: grid_array.transpose, orientation: :column)
  end

  private

  def create_clues!(grid:, orientation:)
    grid.each_with_index do |line, index|
      clue = @board.clues.new(position: index, orientation: orientation)

      clue.lengths = CalculateLengths.new(line: line).call
      clue.save!
    end
  end
end
