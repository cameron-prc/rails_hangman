require 'rails_helper'

RSpec.describe GuessesController, type: :controller do
  let(:valid_attributes) { { letter: letter } }
  let(:letter) { "a" }
  let(:game) { Game.create!(target_word: "test", lives: 5) }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      Guess.create! valid_attributes.merge(game_id: game.id)
      get :index, params: { game_id: game.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      guess = Guess.create! valid_attributes.merge(game_id: game.id)
      get :show, params: { id: guess.to_param, game_id: game.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { game_id: game.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Guess" do
        expect {
          post :create, params: { guess: valid_attributes, game_id: game.id }, session: valid_session
        }.to change(Guess, :count).by(1)
      end

      it "redirects to the created guess" do
        post :create, params: { guess: valid_attributes, game_id: game.id }, session: valid_session
        expect(response).to redirect_to(game_path(game))
      end
    end

    context "without a valid game" do
      it "returns a success response (i.e. to display the 'new' template)" do
        expect {
          post :create, params: { guess: valid_attributes }, session: valid_session
        }.to raise_error
        expect(response).to be_successful
      end
    end

    context "without a valid letter" do
      let(:letter) { "ab" }

      it "returns a success response (i.e. to display the 'new' template)" do
        expect {
          post :create, params: { guess: valid_attributes, game_id: game.id }, session: valid_session
        }.to change(Guess, :count).by(0)
        expect(response).to be_successful
      end
    end
  end
end
