class GuessesController < ApplicationController
  before_action :set_game

  # GET /guesses
  def index
    @guesses = @game.guesses.all
  end

  # GET /guesses/1
  def show
    @guess = Guess.find(params[:id])
  end

  # GET /guesses/new
  def new
    @guess = @game.guesses.new
  end

  # POST /guesses
  def create
    @guess = @game.guesses.build(guess_params)

    respond_to do |format|
      if @guess.save
        format.html { redirect_to game_path(@game), notice: 'Guess was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @guess.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def guess_params
    params.require(:guess).permit(:letter)
  end
end
