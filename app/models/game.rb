class Game < ApplicationRecord
    has_many :guesses

    validates :target_word, presence: true
    validates :lives, presence: true
    validates :lives, numericality: { only_integer: true, greater_than: 0 }
end
