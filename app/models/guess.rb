class Guess < ApplicationRecord
  belongs_to :game, optional: false

  validates :letter, presence: true
  validates :letter, length: { is: 1 }
  validates :letter, uniqueness: { scope: :game }
  validate :validates_game_is_active
  validate :validates_duplicate_guesses

  private

  def validates_game_is_active
    return unless game

    errors.add(:game, "has already been completed") unless game.active?
  end
end
