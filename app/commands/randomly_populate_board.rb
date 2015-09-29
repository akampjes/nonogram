class RandomlyPopulateBoard
  def initialize(board:, max_colors:)
    @board = board
    @max_colors = max_colors
  end

  def call
    # rowlines -> rows
    # want to create a board from in here
    # need to extend board to allow it to do these things
    @board.row_lines.map! do |columns|
      columns.map do |cell|
        random_color_or_blank
      end
    end

    # do i really need to be returning this?
    # I would if i refactored board
    @board
  end

  private

  def random_color_or_blank
    if rand <  0.5
      random_color_value = rand(0...@max_colors) * (255 / @max_colors)

      "hsl(#{random_color_value}, 90%, 50%)"
    end
  end
end
