class RenameGameToBoardOnClue < ActiveRecord::Migration
  def change
    rename_column :clues, :game_id, :board_id
  end
end
