class Game < ApplicationRecord
  has_many :guesses, dependent: :destroy

  validates :target_word, presence: true
  validates :lives, presence: true
  validates :lives, numericality: { only_integer: true, greater_than: 0 }

  def won?
    !lost? && (target_word.split("") - guessed_letters).empty?
  end

  def lost?
    incorrect_guesses >= lives
  end

  def active?
    !(lost? or won?)
  end

  def incorrect_guesses
    valid_letters = target_word.split("")
    incorrect_guesses = 0

    guesses.where.not(id: nil).each do |guess|
      incorrect_guesses += 1 unless valid_letters.include? guess.letter
    end

    incorrect_guesses
  end

  def guessed_letters
    guesses.where.not(id: nil).map(&:letter)
  end
end
