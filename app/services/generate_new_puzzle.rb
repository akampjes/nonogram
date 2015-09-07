class GenerateNewPuzzle
  def initialize(game:)
    @game = game
  end

  def call
    grid = Grid.new(size: @game.board_size)

    grid.randomly_populate!
    grid.create_clues!(@game)

    print grid.display_string(@game)
  end
end
