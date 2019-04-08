class Guess < ApplicationRecord
  belongs_to :game

  validates :letter, presence: true
  validates_length_of :letter, is: 1
end
