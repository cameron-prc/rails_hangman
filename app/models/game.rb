class Game < ApplicationRecord
    validates :target_word, presence: true
    validates :lives, presence: true
    validates :lives, numericality: { greater_than: 0 }
end
