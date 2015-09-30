class Legend < ActiveRecord::Base
  belongs_to :puzzle
  has_many :clues, dependent: :destroy

  enum orientation: [:row, :column]

  scope :for_columns, -> { where(orientation: orientations[:column]).order(:position) }
  scope :for_rows, -> { where(orientation: orientations[:row]).order(:position) }

  validates :puzzle, :orientation, presence: true
  validate :check_position_is_in_range

  private

  def check_position_is_in_range
    errors.add(:position, 'outside of grid') unless inside_grid?
  end

  def inside_grid?
    puzzle.present? && (0...puzzle.board_size).include?(position)
  end
end
