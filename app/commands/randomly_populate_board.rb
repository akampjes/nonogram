class RandomlyPopulateBoard
  def initialize(board: board, max_colors: max_colors)
    @board = board
    @max_colors = max_colors
  end

  def call
    randomly_populate!

    # I don't think I need to return this
    @board
  end

  private

  def randomly_populate!
    @board.row_lines.map! do |columns|
      columns.map do |cell|
        random_cell
      end
    end

    self
  end

  def pick_color(random_value)
    # Normalise based on number of colors we have
    normalised_random_value = ((random_value * 100).to_i % @max_colors)

    # Pick a section of the color space
    (normalised_random_value * (255 / @max_colors)).to_i
  end

  def random_cell
    # About 50% chance of dark square seems to generate alright puzzles
    random_cell_value = rand

    if random_cell_value < 0.5
      pick_color(random_cell_value).to_s
    else
      nil
    end
  end
end