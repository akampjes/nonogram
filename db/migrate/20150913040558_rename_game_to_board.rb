class RenameGameToBoard < ActiveRecord::Migration
  def change
    rename_table :games, :boards
  end
end
