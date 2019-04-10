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
    guesses.where.not(id: nil).count do |guess|
      !target_letters.include?(guess.letter)
    end
  end

  def target_letters
    target_word.chars
  end

  def guessed_letters
    guesses.where.not(id: nil).map(&:letter)
  end

  def lives_remaing
    lives - incorrect_guesses
  end
end
