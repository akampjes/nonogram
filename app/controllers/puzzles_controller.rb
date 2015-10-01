class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.all
  end

  def show
    @puzzle = Puzzle.find(params[:id])
    @distinct_colors = Clue.includes(:legend).where(legends: {puzzle_id: @puzzle.id}).pluck(:color).uniq.reject(&:blank?)
  end

  def new
    @puzzle = Puzzle.new
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)

    board = Board.new(size: @puzzle.board_size)
    board = RandomlyPopulateBoard.new(board: board, max_colors: @puzzle.max_colors).call
    GenerateLegendsOnPuzzle.new(puzzle: @puzzle, board: board).call

    if @puzzle.save
      redirect_to puzzle_path(@puzzle)
    else
      render :new
    end
  end

  def check_solution
    # Could use #update for this but it's not really updating the puzzle
    # I could make an entire controller just to take #create on a solution
    # do the check there but because we don't persist but rather just
    # query, I feel like this is sufficient.
    if won?
      render json: {won: true, message: 'yup you win!'}
    else
      render json: {won: false, message: 'nope, try again'}
    end
  end

  private

  def won?
    puzzle = Puzzle.find(params[:id])

    cells = params[:boxes].map { |box| Cell.new(row: box[:row], column: box[:column], color: box[:color]) }
    board = Board.new(size: puzzle.board_size).populate_from_cells(cells)

    CheckSolution.new(puzzle: puzzle, board: board).call
  end
  
  def puzzle_params
    params.require(:puzzle).permit(:board_size, :max_colors)
  end
end
