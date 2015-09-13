class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    GenerateNewPuzzle.new(board: @board).call

    if @board.save
      redirect_to board_path(@board)
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
    board = Board.find(params[:id])

    grid = Grid.new(size: board.board_size).from_selected_tiles(params[:selected]).grid
    CheckAnswer.new(board: board, grid: grid).call
  end
  
  def board_params
    params.require(:board).permit(:board_size)
  end
end
