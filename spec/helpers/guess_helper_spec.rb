require "spec_helper"

RSpec.describe GuessHelper, type: :helper do
  let(:target_word) { "word" }
  let(:guessed_letters) { [] }

  describe "generate_obfuscated_word" do
    context "with no guesses" do
      it "returns a string of padded underscores only" do
        helper.generate_obfuscated_word(target_word, guessed_letters).should == " _  _  _  _ "
      end
    end

    context "with no correct guesses" do
      let(:guessed_letters) { %w[a] }

      it "returns a string of padded underscores only" do
        helper.generate_obfuscated_word(target_word, guessed_letters).should == " _  _  _  _ "
      end
    end

    context "with correct guesses" do
      let(:guessed_letters) { %w[w] }

      it "returns a padded string where correct letters are displayed and missing letters are underscores" do
        helper.generate_obfuscated_word(target_word, guessed_letters).should == " w  _  _  _ "
      end
    end

    context "with incorrect guesses" do
      let(:guessed_letters) { %w[w t] }

      it "returns a padded string where inorrect letters do not effect the output" do
        helper.generate_obfuscated_word(target_word, guessed_letters).should == " w  _  _  _ "
      end
    end

    context "with mulitple of the same guessed letter has each matching letter displayed" do
      let(:target_word) { "test" }
      let(:guessed_letters) { %w[t] }

      it "returns a padded string where correct letters are displayed and missing letters are underscores" do
        helper.generate_obfuscated_word(target_word, guessed_letters).should == " t  _  _  t "
      end
    end
  end
end
