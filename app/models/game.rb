class Game < ApplicationRecord
  has_many :guesses, dependent: :destroy

  validates :target_word, presence: true
  validates :lives, presence: true
  validates :lives, numericality: { only_integer: true, greater_than: 0 }

  def won?
    !lost? && (target_letters - guessed_letters).empty?
  end

  def lost?
    incorrect_guesses >= lives
  end

  def active?
    !(lost? || won?)
  end

  def incorrect_guesses
    incorrect_guesses = 0

    guesses.where.not(id: nil).find_each do |guess|
      incorrect_guesses += 1 unless target_letters.include? guess.letter
    end

    incorrect_guesses
  end

  def target_letters
    target_word.chars
  end

  def guessed_letters
    guesses.where.not(id: nil).map(&:letter)
  end
end
