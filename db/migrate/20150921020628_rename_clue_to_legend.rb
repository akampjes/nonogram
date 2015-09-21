class RenameClueToLegend < ActiveRecord::Migration
  def change
    rename_column :clues, :legend, :clues
    rename_table :clues, :legends
  end
end
