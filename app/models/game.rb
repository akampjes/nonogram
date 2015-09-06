class Game < ActiveRecord::Base
  has_many :clues

  validates :board_size, numericality: { greater_than_or_equal_to: 5 }

  #scope :column_clues, -> { clues.where(orientation: Clue.orientations[:column]).order(:position) }
  #scope :row_clues, -> { clues.where(orientation: Clue.orientations[:row]).order(:position) }

  def column_clues
    clues.where(orientation: Clue.orientations[:column]).order(:position)
  end

  def row_clues
    clues.where(orientation: Clue.orientations[:row]).order(:position)
  end
end
