class Legend < ActiveRecord::Base
  belongs_to :puzzle
  has_many :clues, -> { order :position }

  enum orientation: [:row, :column]

  validates :puzzle, presence: true
  validates :orientation, presence: true
  # double validate in naming
  validate :validate_position_is_in_range

  scope :for_columns, -> { where(orientation: Legend.orientations[:column]).order(:position) }
  scope :for_rows, -> { where(orientation: Legend.orientations[:row]).order(:position) }

  def validate_position_is_in_range
    return unless position.present? && puzzle.present?

    unless position >= 0 && position < puzzle.board_size
      errors.add(:position, 'outside of grid')
    end
  end
end
