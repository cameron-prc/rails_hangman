require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "validations" do
    let(:game) { Game.new(target_word: target_word, lives: lives) }
    let(:target_word) { "word" }
    let(:lives) { 5 }

    context "when target word and lives are present and valid" do
      it "is valid" do
        expect(game).to be_valid
      end
    end

    context "when target word is blank" do
      let(:target_word) { "" }

      it "Validates target word exists" do
        expect(game).to be_invalid
        expect(game.errors[:target_word].size).to eq(1)
      end
    end

    context "when lives are blank" do
      let(:lives) { nil }

      it "Validates presence of lives" do
        expect(game).to be_invalid
        expect(game.errors[:lives].include?("can't be blank")).to eq(true)
      end
    end

    context "when lives are present but less than 0" do
      let(:lives) { 0 }

      it "is invalid" do
        expect(game).to be_invalid
        expect(game.errors[:lives].include?("must be greater than 0")).to eq(true)
      end
    end
  end
end