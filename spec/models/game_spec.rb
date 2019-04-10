require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { Game.new(target_word: target_word, lives: lives) }
  let(:target_word) { "target" }
  let(:lives) { 5 }

  describe "validations" do
    context "when target word and lives are present and valid" do
      it "is valid" do
        expect(game).to be_valid
      end
    end

    context "when target word is blank" do
      let(:target_word) { "" }

      it "validates target word exists" do
        expect(game).to be_invalid
        expect(game.errors[:target_word].size).to eq(1)
      end
    end

    context "when lives are blank" do
      let(:lives) { nil }

      it "validates presence of lives" do
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

  describe "state" do
    before(:each) do
      game.save!
    end

    context "when each letter has been correctly guessed and incorrect guesses < lives" do
      before(:each) do
        letters = game.target_word.chars.uniq!

        letters.each do |letter|
          game.guesses.create!(letter: letter)
        end
      end

      it "is not reporting active" do
        expect(game.active?).to be(false)
      end

      it "is reporting won" do
        expect(game.won?).to be(true)
      end

      it "is not reporting lost" do
        expect(game.lost?).to be(false)
      end
    end

    context "when each letter has been correctly guessed and incorrect guesses >= lives" do
      before(:each) do
        letters = game.target_word.chars.uniq!

        letters |= %w[z x c v b]

        # Validations are disabled here as they prevent the game from entering this state
        letters.each do |letter|
          game.guesses.new(letter: letter).save(validate: false)
        end
      end

      it "is not reporting active" do
        expect(game.active?).to be(false)
      end

      it "is not reporting won" do
        expect(game.won?).to be(false)
      end

      it "is is reporting lost" do
        expect(game.lost?).to be(true)
      end
    end

    context "when each letter has not been correctly guessed and incorrect guesses < lives" do
      it "is reporting active" do
        expect(game.active?).to be(true)
      end

      it "is not reporting won" do
        expect(game.won?).to be(false)
      end

      it "is not reporting lost" do
        expect(game.lost?).to be(false)
      end
    end

    context "when each letter has not been correctly guessed and incorrect guesses >= lives" do
      before(:each) do
        %w[z x c v b].each do |letter|
          game.guesses.create!(letter: letter)
        end
      end

      it "is reporting active" do
        expect(game.active?).to be(false)
      end

      it "is not reporting won" do
        expect(game.won?).to be(false)
      end

      it "is not reporting lost" do
        expect(game.lost?).to be(true)
      end
    end
  end

  describe "guesses" do
    let(:letter) { "z" }

    before(:each) do
      game.save!
    end

    context "when correct" do
      let(:letter) { game.target_word.chars.first }

      before(:each) do
        game.guesses.create!(letter: letter)
      end

      it "does not get calculated as incorrect" do
        expect(game.incorrect_guesses).to eq(0)
      end

      it "is achknowledged as a guess" do
        game.guessed_letters.should == [letter]
      end
    end

    context "when incorrect" do
      before(:each) do
        game.guesses.create!(letter: letter)
      end

      it "gets calculated as incorrect" do
        expect(game.incorrect_guesses).to eq(1)
      end

      it "is achknowledged as a guess" do
        game.guessed_letters.should == [letter]
      end
    end

    context "when unsaved" do
      let(:lives) { 1 }

      it "does not count towards game state validation" do
        game.guesses.build(letter: letter)

        expect(game.lost?).to be(false)
        expect(game.won?).to be(false)
        expect(game.active?).to be(true)
      end

      it "does not count towards incorrect guesses" do
        game.guesses.build(letter: letter)

        expect(game.incorrect_guesses).to eq(0)
      end

      it "is not achnkowledged as a guess" do
        game.guesses.build(letter: letter)

        expect(game.guessed_letters.include?(letter)).to eq(false)
      end
    end
  end
end
