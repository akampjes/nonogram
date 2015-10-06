class Board
  def initialize(size:, cells: [])
    @board = Array.new(size) { Array.new(size) }

    cells.each do |cell|
      @board[cell.row][cell.column] = cell.color
    end
  end

  def rows
    @board
  end

  def columns
    @board.transpose
  end
end
