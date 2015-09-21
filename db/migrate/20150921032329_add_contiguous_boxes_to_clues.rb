class AddContiguousBoxesToClues < ActiveRecord::Migration
  def change
    add_column :clues, :contiguous_boxes, :integer
    add_column :clues, :color, :text
  end
end
