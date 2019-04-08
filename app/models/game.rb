class Game < ApplicationRecord
    has_many :guesses

    validates :target_word, presence: true
    validates :lives, presence: true
    validates :lives, numericality: { only_integer: true, greater_than: 0 }

    def has_won?
        guessed_letters = guesses.map do |guess|
            guess.letter
        end

        (target_word.split("") - guessed_letters).empty?
    end

    def has_lost?
        incorrect_guesses >= self.lives
    end

    def active?
        !(has_lost? || has_won?)
    end

    def incorrect_guesses
        valid_letters = target_word.split("")
        incorrect_guesses = 0

        guesses.each do |guess|
            incorrect_guesses += 1 unless valid_letters.include? guess.letter
        end

        incorrect_guesses
    end
end
