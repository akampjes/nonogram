class GridPresenter < SimpleDelegator
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

    result = ''

    # First add all the clues for the columns
    n = column_clues[0].length
    for i in 0..n-1
      result << (' '*n).to_s
      column_clues.each do |row|
        result << (row[i] || ' ').to_s
      end
      result << "\n"
    end

    for i in board_range
      # Next add all the clues for the rows
      row_clues[i].each do |clue|
        result << (clue || ' ').to_s
      end

      # And also actual grid values
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


end
