require 'rails_helper'

RSpec.describe Guess, type: :model do
  describe "validations" do
    let(:game) { Game.create!(target_word: "word", lives: lives) }
    let(:guess) { Guess.new(letter: letter, game: game) }
    let(:letter) { "a" }
    let(:lives) { 5 }

    context "when a valid game and letter is present and valid" do
      it "is valid" do
        expect(guess).to be_valid
      end
    end

    context "when the game is missing" do
      let(:game) { nil }

      it "validates that game exists" do
        expect(guess).to be_invalid
        p guess.errors[:game]

        expect(guess.errors[:game].include?("must exist")).to eq(true)
      end
    end

    context "when the letter is missing" do
      let(:letter) { nil }

      it "validates that letter exists" do
        expect(guess).to be_invalid

        expect(guess.errors[:letter].include?("can't be blank")).to eq(true)
      end
    end

    context "when the letter is > 1 char" do
      let(:letter) { "ab" }

      it "validates that letter is valid" do
        expect(guess).to be_invalid

        expect(guess.errors[:letter].include?("is the wrong length (should be 1 character)")).to eq(true)
      end
    end

    context "when the target game is complete" do
      before do
        %w[w o r d].each do |char|
          game.guesses.create!(letter: char)
        end
      end

      it "cannot be added to it" do
        expect(guess).to be_invalid
      end
    end
  end
end
