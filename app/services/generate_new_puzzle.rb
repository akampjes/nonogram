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

      clue.lengths = calculate_lengths(line)
      clue.save!
    end
  end

  def calculate_lengths(line)
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

    lengths
  end

  def board_range
    0..(@game.board_size - 1)
  end
end
