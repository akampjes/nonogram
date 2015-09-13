class Board < ActiveRecord::Base
  has_many :clues
  has_many :column_clues, -> { column_clues }, class_name: 'Clue'
  has_many :row_clues, -> { row_clues }, class_name: 'Clue'

  validates :board_size, numericality: { greater_than_or_equal_to: 5 }
end
