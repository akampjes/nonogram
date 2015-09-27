class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.all
  end

  def show
    @puzzle = Puzzle.find(params[:id])
    # Calculate all the possible colors
    @distinct_colors = (0..@puzzle.max_colors-1).map { |x| x * (255 / @puzzle.max_colors)}
    # Or query the ones that we happen to have
    #@distinct_colors = Clue.includes(:legend).where(legends: {puzzle: @puzzle}).select(:color).distinct
  end

  def new
    @puzzle = Puzzle.new
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)
    GenerateLegendsOnPuzzle.new(puzzle: @puzzle).call

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

    board = Board.new(size: puzzle.board_size, colors: puzzle.max_colors).from_boxes(params[:boxes])
    CheckSolution.new(puzzle: puzzle, board: board).call
  end
  
  def puzzle_params
    params.require(:puzzle).permit(:board_size, :max_colors)
  end
end
