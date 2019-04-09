class CreateGuesses < ActiveRecord::Migration[5.2]
  def change
    create_table :guesses do |t|
      t.references :game, foreign_key: true
      t.string :letter, :limit => 1

      t.timestamps
    end
  end
end
