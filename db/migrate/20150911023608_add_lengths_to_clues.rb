class AddLengthsToClues < ActiveRecord::Migration
  def change
    add_column :clues, :lengths, :integer, array:true, default: []
    remove_column :clues, :values
  end
end
