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
        format.js { render :create, locals: { guess: @game.guesses.new } }
      else
        format.html { render :new }
        format.js
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
