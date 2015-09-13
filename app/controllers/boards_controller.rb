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
    board = Board.find(params[:id])

    grid = Grid.new(size: board.board_size).from_answer(params[:selected]).grid
    board_status = CheckAnswer.new(board: board, grid: grid).call # board_status is an awful name, wtf is a "status.
    # why not just have `if won?` with won? being a private method that does this.
    # message should be view logic.

    if board_status
      render json: {won: true, message: 'yup you win!'}
    else
      render json: {won: false, message: 'nope, try again'}
    end
  end

  private
  def board_params
    params.require(:board).permit(:board_size)
  end
end
