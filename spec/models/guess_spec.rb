require 'rails_helper'

RSpec.describe Guess, type: :model do
  describe "validations" do
    let(:game) { Game.new(target_word: "word", lives: 5) }
    let(:guess) { Guess.new(game: game, letter: letter) }
    let(:letter) { "a" }

    context "when a valid game and letter is present and valid" do
      it "is valid" do
        expect(guess).to be_valid
      end
    end

    context "When game is missing" do
      let(:game) { nil }

      it "Validates that game exists" do
        expect(guess).to be_invalid
        p guess.errors[:game]

        expect(guess.errors[:game].include? "must exist").to eq(true)
      end
    end

    context "When letter is missing" do
      let(:letter) { nil }

      it "Validates that game exists" do
        expect(guess).to be_invalid

        expect(guess.errors[:letter].include? "can't be blank").to eq(true)
      end
    end

    context "When letter is > 1 char" do
      let(:letter) { "ab" }

      it "Validates that game exists" do
        expect(guess).to be_invalid

        expect(guess.errors[:letter].include? "is the wrong length (should be 1 character)").to eq(true)
      end
    end
  end
end
