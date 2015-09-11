class Clue < ActiveRecord::Base
  belongs_to :game 

  enum orientation: [:row, :column]

  validates :game, presence: true
  validates :orientation, presence: true
  validate :validate_position

  scope :column_clues, -> { where(orientation: Clue.orientations[:column]).order(:position) }
  scope :row_clues, -> { where(orientation: Clue.orientations[:row]).order(:position) }

  def validate_position
    unless position < game.board_size
      errors.add(:position, 'outside of grid')
    end
  end
end
