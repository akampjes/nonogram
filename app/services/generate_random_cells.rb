class GenerateRandomCells
  def initialize(board_size:, max_colors:)
    @board_size = board_size
    @max_colors = max_colors
  end

  def call
    cells = []
    (0...@board_size).each do |row|
      (0...@board_size).each do |column|
        cells << Cell.new(row: row, column: column, color: random_color_or_blank)
      end
    end

    cells
  end

  private

  COLORS = ['#ff0000', '#00ff00', '#0000ff']

  def random_color_or_blank
    if rand <  0.5
      random_color_value = rand(0...@max_colors) * (255 / @max_colors)

      "hsl(#{random_color_value}, 90%, 50%)"

      #COLORS.sample
    end
  end
end
