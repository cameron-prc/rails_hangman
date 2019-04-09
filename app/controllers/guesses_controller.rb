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

    if @guess.save
      redirect_to game_guess_path(@game, @guess), notice: 'Guess was successfully created.'
    else
      render :new
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
