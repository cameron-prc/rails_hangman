module GameHelper
  def calculate_game_status_text(game)
    game.active? ? "Continue" : (game.lost? ? "Lost" : "Won")
  end
end
