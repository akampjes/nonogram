class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.all
  end

  def show
    @puzzle = Puzzle.find(params[:id])
  end

  def new
    @puzzle = Puzzle.new
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)
    GenerateNewPuzzle.new(puzzle: @puzzle).call

    if @puzzle.save
      redirect_to puzzle_path(@puzzle)
    else
      render :new
    end
  end

  def check_answer
    if won?
      render json: {won: true, message: 'yup you win!'}
    else
      render json: {won: false, message: 'nope, try again'}
    end
  end

  private

  def won?
    puzzle = Puzzle.find(params[:id])

    grid = Grid.new(size: puzzle.board_size).from_selected_tiles(params[:selected])
    CheckAnswer.new(puzzle: puzzle, grid: grid).call
  end
  
  def puzzle_params
    params.require(:puzzle).permit(:board_size)
  end
end
