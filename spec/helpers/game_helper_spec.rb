require "spec_helper"

RSpec.describe GameHelper, type: :helper do
  let(:game) { Game.create!(target_word: target_word, lives: lives) }
  let(:target_word) { "tea" }
  let(:lives) { 1 }

  describe "calculate game status text" do
    context "with game is active" do
      it "returns an 'active' string" do
        expect(helper.calculate_game_status_text(game)).to eq("Continue")
      end
    end

    context "when game is lost" do
      before do
        game.guesses.create!(letter: "z")
      end

      it "returns a 'lost' string" do
        expect(helper.calculate_game_status_text(game)).to eq("Lost")
      end
    end

    context "when game is won" do
      before do
        target_word.chars.uniq.each { |char| game.guesses.create!(letter: char) }
      end

      it "returns a 'won' string" do
        expect(helper.calculate_game_status_text(game)).to eq("Won")
      end
    end
  end
end
