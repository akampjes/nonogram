class RemoveMaxColorsFromPuzzles < ActiveRecord::Migration
  def change
    remove_column :puzzles, :max_colors
  end
end
