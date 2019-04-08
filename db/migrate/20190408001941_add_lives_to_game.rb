class AddLivesToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :lives, :integer
  end
end
