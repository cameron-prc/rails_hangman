require 'literate_randomizer'

class Game < ApplicationRecord
  has_many :guesses, dependent: :destroy

  validates :target_word, presence: true
  validates :lives, presence: true
  validates :lives, numericality: { only_integer: true, greater_than: 0 }

  DEFAULT_LIVES = 5

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
    guesses.where.not(id: nil).count do |guess|
      !target_letters.include?(guess.letter)
    end
  end

  def target_letters
    target_word.chars
  end

  def guessed_letters
    guesses.select(&:persisted?).map(&:letter)
  end

  def lives_remaining
    lives - incorrect_guesses
  end

  def self.generate_random_word
    LiterateRandomizer.word
  end
end
