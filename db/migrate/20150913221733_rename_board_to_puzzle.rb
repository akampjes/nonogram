class RenameBoardToPuzzle < ActiveRecord::Migration
  def change
    rename_table :boards, :puzzles
    rename_column :clues, :board_id, :puzzle_id
  end
end
