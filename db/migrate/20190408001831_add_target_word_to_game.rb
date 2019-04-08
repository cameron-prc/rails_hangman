class AddTargetWordToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :target_word, :string
  end
end
