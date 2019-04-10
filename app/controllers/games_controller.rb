class GamesController < ApplicationController

  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/1
  def show
    @game = Game.find(params[:id])
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games
  def create
    @game = params[:random] ? Game.new_random_game : Game.new(game_params)

    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  def create_random
    @game = Game.new(target_word: Game.generate_random_word, lives: Game::DEFAULT_LIVES)

    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  private

  def game_params
    params.require(:game).permit(:target_word, :lives)
  end
end
