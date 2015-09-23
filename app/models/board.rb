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

  def randomly_populate!
    @board.map! do |columns|
      columns.map do |cell|
        random_cell
      end
    end

    self
  end

  private

  def pick_color(random_value)
    # Normalise based on number of colors we have
    normalised_random_value = (random_value * 100) % @max_colors

    # Pick a section of the color space
    (normalised_random_value * (255 / @max_colors)).to_i
  end

  def random_cell
    # About 50% chance of dark square seems to generate alright puzzles
    random_cell_value = rand
    if random_cell_value < 0.5
      pick_color(random_cell_value).to_s
    else
      ''
    end
  end
end
