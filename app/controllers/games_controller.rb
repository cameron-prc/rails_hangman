class GamesController < ApplicationController

  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/1
  def show
    @game = Game.find(params[:id])
    @guess = @game.guesses.new
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def obfuscated_target_word
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:target_word, :lives)
  end
end
