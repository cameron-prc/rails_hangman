class Guess < ApplicationRecord
  belongs_to :game, optional: false

  validates :letter, presence: true
  validates :letter, length: { is: 1 }
  validate :validates_game_is_active
  validate :validates_duplicate_guesses

  private

  def validates_game_is_active
    return unless game

    errors.add(:game, "has already been completed") unless game.active?
  end

  def validates_duplicate_guesses
    return unless game

    errors.add(:letter, "has already been guessed") if game.guessed_letters.include?(letter)
  end
end
