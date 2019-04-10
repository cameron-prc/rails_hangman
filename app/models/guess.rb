class Guess < ApplicationRecord
  belongs_to :game, optional: false

  validates :letter, presence: true
  validates :letter, length: { is: 1 }
  validate :validates_game_is_active

  private

  def validates_game_is_active
    return unless game

    errors.add(:game, "has already been completed") unless game.active?
  end
end
