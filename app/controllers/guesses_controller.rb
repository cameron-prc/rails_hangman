class GuessesController < ApplicationController
  before_action :set_guess, only: [:show]
  before_action :set_game

  # GET /guesses
  # GET /guesses.json
  def index
    @guesses = Guess.all
  end

  # GET /guesses/1
  # GET /guesses/1.json
  def show
  end

  # GET /guesses/new
  def new
    @guess = Guess.new
  end

  # POST /guesses
  # POST /guesses.json
  def create
    @guess = @game.guesses.build(guess_params)

    respond_to do |format|
      if @guess.save
        format.html { redirect_to game_guess_path(@game, @guess), notice: 'Guess was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

    def set_game
      @game = Game.find(params[:game_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_guess
      @guess = Guess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guess_params
      params.require(:guess).permit(:letter)
    end
end
