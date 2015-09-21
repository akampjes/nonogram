class Legend < ActiveRecord::Base
  belongs_to :puzzle

  enum orientation: [:row, :column]

  validates :puzzle, presence: true
  validates :orientation, presence: true
  validate :validate_position_is_in_range

  scope :for_columns, -> { where(orientation: Legend.orientations[:column]).order(:position) }
  scope :for_rows, -> { where(orientation: Legend.orientations[:row]).order(:position) }

  def validate_position_is_in_range
    unless position && puzzle && position >= 0 && position < puzzle.board_size 
      errors.add(:position, 'outside of grid')
    end
  end
end
