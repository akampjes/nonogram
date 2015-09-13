class GenerateNewPuzzle
  def initialize(board:)
    @board = board
  end

  def call
    grid = Grid.new(size: @board.board_size).grid

    grid = randomly_populate(grid)

    create_clues!(grid: grid, orientation: :row)
    create_clues!(grid: grid.transpose, orientation: :column)
  end

  private

  def create_clues!(grid:, orientation:)
    grid.each_with_index do |line, index|
      clue = @board.clues.new(position: index, orientation: orientation)

      clue.lengths = CalculateLengths.new(line: line).call
      clue.save!
    end
  end

  def randomly_populate(grid)
    grid.map do |columns|
      columns.map do |tile|
        random_square
      end
    end
  end

  def random_square
    # About 50% chance of dark square seems to generate alright boards
    rand < 0.5 ? true : false
  end
end
