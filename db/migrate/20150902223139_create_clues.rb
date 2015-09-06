class CreateClues < ActiveRecord::Migration
  def change
    create_table :clues do |t|
      t.text :values
      t.integer :position
      t.integer :orientation

      t.timestamps null: false
    end
  end
end
