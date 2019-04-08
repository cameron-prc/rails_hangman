require 'rails_helper'

RSpec.describe Game, type: :model do

  it "Validates target word exists" do
    game = Game.new
    game.valid?
    
    expect(game.errors[:target_word].size).to eq(1)
  end

  it "Validates presence of lives" do
    game = Game.new
    game.valid?

    p game.errors

    expect(game.errors[:lives].include? "can't be blank").to eq(true)
  end

  it "Validates lives are greater than 0" do
    game = Game.new({ lives: -5 })
    game.valid?

    expect(game.errors[:lives].include? "must be greater than 0").to eq(true)
  end

end
