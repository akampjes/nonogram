require "#{Rails.root}/lib/array"

Tile = Struct.new(:tile_type, :content)

class GameGridPresenter < SimpleDelegator
  def rows
    rows = []
    max_column_count = column_clues.values.map(&:count).max
    max_row_count = column_clues.values.map(&:count).max

    clues_grid = []
    column_clues.each do |clue|
      clues_grid << clue.values.map { |value| Tile.new('clue_tile', value) }.lfill(max_column_count, Tile.new('clue_tile', nil))
    end
    clues_grid = transform_column_clues(clues_grid, max_column_count)

    row_clues.each do |clue|
      row = clue.values.map { |value| Tile.new('clue_tile', value) }.lfill(max_row_count, Tile.new('clue_tile', nil))
      board_range.each { row << Tile.new('play_tile', nil) }
      clues_grid << row
    end

    clues_grid
  end

  private

  def board_range
    0..board_size-1
  end

  def transform_column_clues(my_column_clues, max_column_count)
    rows = []
    for i in 0..max_column_count-1
      row = []
      # pad out the left hand side
      max_column_count.times { row << Tile.new('clue_tile',nil) }
      my_column_clues.each do |my_row|
        row << my_row[i]
      end
      rows << row
    end

    rows
  end
end
