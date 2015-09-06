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

  private

  def game_params
    params.require(:game).permit(:board_size)
  end
end
