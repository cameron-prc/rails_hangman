class AddNotNullConstraintsToGame < ActiveRecord::Migration[5.2]
  def change
    change_column :games, :target_word, :string, null: false
    change_column :games, :lives, :integer, null: false
  end
end
