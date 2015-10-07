class GenerateRandomCells
  def initialize(board_size:, number_of_colors:)
    @board_size = board_size
    @number_of_colors = number_of_colors
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

  def random_color_or_blank
    if rand <  0.5
      rand(1..@number_of_colors).to_s
    end
  end
end
