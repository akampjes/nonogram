class Clue < ActiveRecord::Base
  belongs_to :board

  enum orientation: [:row, :column]

  validates :board, presence: true
  validates :orientation, presence: true
  validate :validate_position

  scope :column_clues, -> { where(orientation: Clue.orientations[:column]).order(:position) }
  scope :row_clues, -> { where(orientation: Clue.orientations[:row]).order(:position) }

  def validate_position
    unless position >= 0 && position < board.board_size 
      errors.add(:position, 'outside of grid')
    end
  end
end
