class GenerateRandomPuzzle
  attr_reader :puzzle

  def initialize(puzzle_params: puzzle_params)
    @puzzle = Puzzle.new(puzzle_params)
    @number_of_colors = puzzle_params[:number_of_colors].to_i
  end

  def call
    cells = GenerateRandomCells.new(board_size: @puzzle.board_size, number_of_colors: @number_of_colors).call
    board = Board.new(size: @puzzle.board_size, cells: cells)
    GenerateLegendsOnPuzzle.new(puzzle: @puzzle, board: board).call

    @puzzle.save
  end
end