class Clue < ActiveRecord::Base
  belongs_to :puzzle

  enum orientation: [:row, :column]

  validates :puzzle, presence: true
  validates :orientation, presence: true
  validate :validate_position_is_in_range

  scope :for_columns, -> { where(orientation: Clue.orientations[:column]).order(:position) }
  scope :for_rows, -> { where(orientation: Clue.orientations[:row]).order(:position) }

  def validate_position_is_in_range
    unless position >= 0 && position < puzzle.board_size 
      errors.add(:position, 'outside of grid')
    end
  end
end
