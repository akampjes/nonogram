class AddDefaultValueOnMaxColorsForPuzzles < ActiveRecord::Migration
  def change
    change_column_default :puzzles, :max_colors, 1
  end
end
