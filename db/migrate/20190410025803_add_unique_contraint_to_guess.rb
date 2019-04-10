class AddUniqueContraintToGuess < ActiveRecord::Migration[5.2]
  def change
    add_index :guesses, [:game_id, :letter], unique: true
  end
end
