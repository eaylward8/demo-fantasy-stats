class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.belongs_to :owner
      t.belongs_to :season
      t.string :name
      t.integer :wins
      t.integer :losses
      t.integer :ties
      t.integer :moves
      t.integer :final_rank
      t.boolean :made_playoffs

      t.timestamps
    end
  end
end
