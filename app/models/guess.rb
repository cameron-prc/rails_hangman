class Guess < ApplicationRecord
  belongs_to :game, required: true

  validates :letter, presence: true
  validates :letter, length: { is: 1 }
end
