class AddMaxColorsToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :max_colors, :integer
  end
end
