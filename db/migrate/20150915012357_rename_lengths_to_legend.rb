class RenameLengthsToLegend < ActiveRecord::Migration
  def change
    rename_column :clues, :lengths, :legend
  end
end
