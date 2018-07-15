class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.belongs_to :season
      t.integer :week
      t.integer :game_number

      t.timestamps
    end
  end
end
