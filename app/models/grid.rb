class Grid
  def initialize(size:)
    @grid = Array.new(size) { Array.new(size) }
  end

  def randomly_populate!
    for i in board_range
      for j in board_range
        @grid[i][j] = random_square
      end
    end
  end

  def create_clues!(game)
    for column in board_range
      clue = game.clues.new(position: column, orientation: :column)

      run = 0
      values = []
      for row in board_range
        if @grid[row][column]
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
      clue = game.clues.new(position: row, orientation: :row)

      run = 0
      values = []
      for column in board_range
        if @grid[row][column]
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

  # Crappy method for debugging/testing things
  def display_string(game)
    column_clues = []
    game.column_clues.each do |clue|
      column_clues << clue.values.lfill(4, nil)
    end

    row_clues = []
    game.row_clues.each do |clue|
      row_clues << clue.values.lfill(4, nil)
    end

    n = column_clues[0].length

    result = ''
    for i in 0..n-1
      result << (' '*n).to_s
      column_clues.each do |row|
        result << (row[i] || ' ').to_s
      end
      result << "\n"
    end

    for i in board_range
      row_clues[i].each do |clue|
        result << (clue || ' ').to_s
      end
      for j in board_range
        if @grid[i][j]
          result << 'x'
        else
          result << '_'
        end
      end
      result << "\n"
    end

    result
  end

  private

  def random_square
    # About 50% chance of dark square seems to generate alright boards
    rand < 0.5 ? true : false
  end

  def board_range
    0..(@grid.length - 1)
  end
end
