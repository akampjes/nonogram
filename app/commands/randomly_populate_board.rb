class RandomlyPopulateBoard
  def initialize(board:, max_colors:)
    @board = board
    @max_colors = max_colors
  end

  def call
    cells = []
    (0...@board.rows.length).each do |row|
      (0...@board.columns.length).each do |column|
        cells << Cell.new(row: row, column: column, color:random_color_or_blank)
      end
    end

    @board.from_cells(cells)
  end

  private

  def random_color_or_blank
    if rand <  0.5
      random_color_value = rand(0...@max_colors) * (255 / @max_colors)

      "hsl(#{random_color_value}, 90%, 50%)"
    end
  end
end
