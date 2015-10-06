class GenerateRandomPuzzle
  attr_reader :puzzle

  def initialize(puzzle_params: puzzle_params)
    @puzzle = Puzzle.new(puzzle_params)
  end

  def call
    cells = GenerateRandomCells.new(board_size: @puzzle.board_size, max_colors: @puzzle.max_colors).call
    board = Board.new(size: @puzzle.board_size, cells: cells)
    GenerateLegendsOnPuzzle.new(puzzle: @puzzle, board: board).call

    @puzzle.save
  end
end