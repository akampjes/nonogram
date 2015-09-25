class Board
  def initialize(size:, colors: 1)
    @board = Array.new(size) { Array.new(size) }
    @max_colors = colors
  end

  def row_lines
    @board
  end

  def column_lines
    @board.transpose
  end

  def from_boxes(boxes)
    return self if boxes.blank?
    boxes.each do |cell|
      row = cell[:row]
      column = cell[:column]
      @board[row.to_i][column.to_i] = cell[:color]
    end

    self
  end
end
