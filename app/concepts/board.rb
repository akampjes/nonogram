class Board
  def initialize(size:)
    @board = Array.new(size) { Array.new(size) }
  end

  def rows
    @board
  end

  def columns
    @board.transpose
  end

  def from_cells(cells)
    return self if cells.blank?

    cells.each do |cell|
      @board[cell.row][cell.column] = cell.color
    end

    self
  end
end
