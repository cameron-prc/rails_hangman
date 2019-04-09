class Guess < ApplicationRecord
  belongs_to :game, optional: false

  validates :letter, presence: true
  validates :letter, length: { is: 1 }
end
