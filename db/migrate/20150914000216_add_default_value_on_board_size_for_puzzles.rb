class AddDefaultValueOnBoardSizeForPuzzles < ActiveRecord::Migration
  def change
    change_column_default :puzzles, :board_size, 5
  end
end
