class Board
  def initialize(size:)
    @board = Array.new(size) { Array.new(size) }
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
      @board[row.to_i][column.to_i] = true
    end

    self
  end

  def randomly_populate!
    @board.map! do |columns|
      columns.map do |cell|
        random_square
      end
    end

    self
  end

  private

  def random_square
    # About 50% chance of dark square seems to generate alright puzzles
    rand < 0.5 ? true : false
  end
end
