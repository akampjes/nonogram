class GenerateNewPuzzle
  def initialize(game:)
    @game = game
  end

  def call
    grid = Grid.new(size: @game.board_size)

    grid_array = grid.randomly_populate!
    create_clues!(grid_array)

    print grid.display_string(@game)
  end

  private

  def create_clues!(grid)
    for column in board_range
      clue = @game.clues.new(position: column, orientation: :column)

      run = 0
      values = []
      for row in board_range
        if grid[row][column]
          run += 1
        elsif run > 0
          values << run
          run = 0
        end
      end

      if run > 0
        values << run
      end

      clue.values = values
      clue.save!
    end

    for row in board_range
      clue = @game.clues.new(position: row, orientation: :row)

      run = 0
      values = []
      for column in board_range
        if grid[row][column]
          run += 1
        elsif run > 0
          values << run
          run = 0
        end
      end

      if run > 0
        values << run
      end

      clue.values = values
      clue.save!
    end
  end

  def board_range
    0..(@game.board_size - 1)
  end
end
