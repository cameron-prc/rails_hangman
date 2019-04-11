require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:valid_attributes) { { target_word: "testWord", lives: 5 } }
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      Game.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      game = Game.create! valid_attributes
      get :show, params: { id: game.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Game" do
        expect {
          post :create, params: { game: valid_attributes }, session: valid_session
        }.to change(Game, :count).by(1)
      end

      it "redirects to the created game" do
        post :create, params: { game: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Game.last)
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { { lives: -1 } }

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { game: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end

    context "with random flag" do
      it "creates a new Game" do
        expect {
          post :create, params: { random: 1 }, session: valid_session
        }.to change(Game, :count).by(1)
      end

      it "redirects to the created game" do
        post :create, params: { random: 1 }, session: valid_session
        expect(response).to redirect_to(Game.last)
      end
    end
  end
end
