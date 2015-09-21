class CreateClues < ActiveRecord::Migration
  def change
    create_table :clues do |t|
      t.integer :legend_id
      t.integer :position

      t.timestamps null: false
    end

    remove_column :legends, :clues
  end
end
