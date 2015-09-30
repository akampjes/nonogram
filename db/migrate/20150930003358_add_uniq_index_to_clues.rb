class AddUniqIndexToClues < ActiveRecord::Migration
  def change
    add_index :clues, [:position, :legend_id], unique: true
  end
end
