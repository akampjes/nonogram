class Array
  def lfill(pad_length, pad_value)
    self.reverse!
    self.fill(pad_value, (self.length..(pad_length-1)))
    self.reverse!
  end
end

Tile = Struct.new(:tile_type, :content)

class GameGridPresenter < SimpleDelegator
  def rows
    rows = []
    max_column_count = column_clues.values.map(&:count).max
    max_row_count = column_clues.values.map(&:count).max

    my_column_clues = []
    column_clues.each do |clue|
      my_column_clues << clue.values.map { |value| Tile.new('clue_tile', value) }.lfill(max_column_count, Tile.new('clue_tile', nil))
    end
    my_column_clues = transform_column_clues(my_column_clues)

    my_row_clues = []
    row_clues.each do |clue|
      row = clue.values.map { |value| Tile.new('clue_tile', value) }.lfill(max_row_count, Tile.new('clue_tile', nil))
      board_range.each { row << Tile.new('play_tile', nil) }
      my_row_clues << row
    end

    my_column_clues + my_row_clues
  end

  def board_range
    0..board_size-1
  end

  def transform_column_clues(my_column_clues)
    n = my_column_clues[0].length

    rows = []
    for i in 0..n-1
      row = []
      # pad out the left hand side
      n.times { row << Tile.new('clue_tile',nil) }
      my_column_clues.each do |my_row|
        row << my_row[i]
      end
      rows << row
    end

    rows
  end

  def x_rows
    # returns an array of everything to be display in each column
    rows = []
    max_col_count = column_clues.values.map(&:count).max
    max_row_count = column_clues.values.map(&:count).max

    ((max_col_count-1)..0).each do |i|
      row = []
      # left justify with blank squares
      (max_row_count..1).each do |j|
        row << Tile.new('','')
      end

      # now print out all the clues
      column_clues do |clue|
        row << Tile.new('clue_tile', clue.values[i].to_s)
      end
      rows << row

      # reverse the rows to display correct order descending
      rows.reverse!
    end

    row_clues do |clue|
      row = []
      clue.values.reverse_each do |value|
        row << Tile.new('clue_tile', value)
      end
      while row.length < max_row_count
        row << Tile.new('clue_tile', nil)
      end
      row.reverse!

      (1..board_size).each do
        row << Tile.new('play_tile', nil)
      end

      rows << row
    end

    # need to enumerate over each row of clues (or blank) spots, for max number of clues
    # then then enumerate over each row of blank play tiles
    # but need to keep correctly left justified with those clues
    # :(
    #
    # fuck this is awful and needs fixing

    rows
  end

  def ascii_rows
    rows
  end

  def private

  end
end
