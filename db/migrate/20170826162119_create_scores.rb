class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.belongs_to :team
      t.belongs_to :game
      t.float :points

      t.timestamps
    end
  end
end
