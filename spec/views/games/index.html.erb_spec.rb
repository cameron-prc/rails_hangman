require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, [
      Game.create!({ target_word: "test", lives: 10}),
      Game.create!({ target_word: "test", lives: 10}),
    ])
  end

  it "renders a list of games" do
    render
  end
end
