class GenerateNewPuzzle
  def initialize(game:)
    @game = game
  end

  def call
    grid = Grid.new(size: @game.board_size)

    grid_array = grid.randomly_populate!

    create_clues!(grid: grid_array, orientation: :row)
    create_clues!(grid: grid_array.transpose, orientation: :column)

    print grid.display_string(@game)
  end

  private

  def create_clues!(grid:, orientation:)
    grid.each_with_index do |line, index|
      clue = @game.clues.new(position: index, orientation: orientation)

      clue.values = calculate_values(line)
      clue.save!
    end
  end

  def calculate_values(line)
    values = []

    run = 0
    line.each do |tile|
      if tile
        run += 1
      elsif run > 0
        values << run
        run = 0
      end
    end

    values << run if run > 0

    values
  end

  def board_range
    0..(@game.board_size - 1)
  end
end
