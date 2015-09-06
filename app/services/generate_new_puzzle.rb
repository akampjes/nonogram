class Array
  def lfill(pad_length, pad_value)
    self.reverse!
    self.fill(pad_value, (self.length..(pad_length-1)))
    self.reverse!
  end
end

class GenerateNewPuzzle
  def initialize(game:)
    @game = game
  end

  def call
    grid = generate_empty_grid(@game.board_size)

    populate_grid!(grid)

    create_clues!(grid)

    display_grid(grid)
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

  def populate_grid!(grid)
    for i in board_range
      for j in board_range
        grid[i][j] = random_square
      end
    end
  end

  def generate_empty_grid(size)
    Array.new(size) { Array.new(size) }
  end

  def random_square
    # About 50% chance of dark square seems to generate alright boards
    rand < 0.5 ? true : false
  end

  def board_range
    0..(@game.board_size - 1)
  end

  # Crappy method for debugging/testing things
  def display_grid(grid)
    column_clues = []
    @game.column_clues.each do |clue|
      column_clues << clue.values.lfill(4, nil)
    end

    row_clues = []
    @game.row_clues.each do |clue|
      row_clues << clue.values.lfill(4, nil)
    end

    n = column_clues[0].length

    for i in 0..n-1
      print ' '*n
      column_clues.each do |row|
        print row[i] || ' '
      end
      print "\n"
    end

    for i in board_range
      row_clues[i].each do |clue|
        print clue || ' '
      end
      for j in board_range
        if grid[i][j]
          print 'x'
        else
          print '_'
        end
      end
      print "\n"
    end
  end
end
