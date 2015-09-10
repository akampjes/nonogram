class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = GameGridPresenter.new(Game.find(params[:id]))
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    GenerateNewPuzzle.new(game: @game).call

    if @game.save
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def check_answer
    game = Game.find(params[:id])

    grid = Grid.new(size: game.board_size).from_answer(params[:selected]).grid
    game_status = CheckAnswer.new(game: game, grid: grid).call

    if game_status
      render json: {won: true, message: 'yup you win!'}
    else
      render json: {won: false, message: 'nope, try again'}
    end
  end

  private

  def game_params
    params.require(:game).permit(:board_size)
  end
end
