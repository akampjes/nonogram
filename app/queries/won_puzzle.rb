class WonPuzzle
  def initialize(params: params)
    @puzzle = Puzzle.find(params[:id])

    if params[:boxes].nil?
      @cells = []
    else
      @cells = params[:boxes].map { |box| Cell.new(row: box[:row], column: box[:column], color: box[:color]) }
    end
  end

  def call
    board = Board.new(size: @puzzle.board_size, cells: @cells)
    CheckSolution.new(puzzle: @puzzle, board: board).call
  end
end