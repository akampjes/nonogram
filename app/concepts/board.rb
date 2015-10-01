class Board
  def initialize(size:)
    @board = Array.new(size) { Array.new(size) }
  end

  # row_lines -> rows
  def row_lines
    @board
  end

  def column_lines
    @board.transpose
  end

  def from_cells(cells)
    return self if cells.blank?

    cells.each do |cell|
      row = cell[:row]
      column = cell[:column]
      @board[row.to_i][column.to_i] = cell[:color]
    end

    self
  end
end
