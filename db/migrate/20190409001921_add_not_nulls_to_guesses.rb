class AddNotNullsToGuesses < ActiveRecord::Migration[5.2]
  def change
    change_column :guesses, :game_id, :bigint, null: false
    change_column :guesses, :letter, :string, null: false, limit: 1
  end
end
