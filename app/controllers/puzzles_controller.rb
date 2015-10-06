class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.all
  end

  def show
    @puzzle = Puzzle.find(params[:id])
    @distinct_colors = Clue.includes(:legend).merge(@puzzle.legends).pluck(:color).uniq.reject(&:blank?)
  end

  def new
    @puzzle = Puzzle.new
  end

  def create
    # Is this approach really better than just returning a Puzzle object that
    # we are then going to save in this controller?
    # Doing it this way spreading out into the controller
    puzzle_generator = GenerateRandomPuzzle.new(puzzle_params: puzzle_params)
    @puzzle = puzzle_generator.puzzle

    if puzzle_generator.call
      redirect_to @puzzle
    else
      render :new
    end
  end

  def check_solution
    # Could use #update for this but it's not really updating the puzzle
    # I could make an entire controller just to take #create on a solution
    # do the check there but because we don't persist but rather just
    # query, I feel like this is sufficient.
    render json: if WonPuzzle.new(params: params).call
                   {won: true, message: 'yup you win!'}
                 else
                   {won: false, message: 'nope, try again'}
                 end
  end

  private

  def puzzle_params
    params.require(:puzzle).permit(:board_size, :max_colors)
  end
end
