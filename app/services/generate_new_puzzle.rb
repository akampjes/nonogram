class GenerateNewPuzzle
  def initialize(game:)
    @game = game
  end

  def call
    grid = Grid.new(size: @game.board_size)

    grid_array = grid.randomly_populate!

    create_clues!(grid: grid_array, orientation: :row)
    create_clues!(grid: grid_array.transpose, orientation: :column)
  end

  private

  def create_clues!(grid:, orientation:)
    grid.each_with_index do |line, index|
      clue = @game.clues.new(position: index, orientation: orientation)

      clue.lengths = CalculateLengths.new(line: line).call
      clue.save!
    end
  end

  def board_range
    0..(@game.board_size - 1)
  end
end
