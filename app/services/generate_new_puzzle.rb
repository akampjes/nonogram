class GenerateNewPuzzle
  def initialize(game:)
    @game = game
  end

  def call
    grid = Grid.new(size: @game.board_size)

    grid.randomly_populate!
    grid.create_clues!(@game)

    # this means that I've now moved everything from a service back into a model.
    # I could probably do create_clues here.

    print grid.display_string(@game)
  end
end
