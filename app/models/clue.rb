class Clue < ActiveRecord::Base
  belongs_to :game 

  enum orientation: [:row, :column]

  validates :game, presence: true
  validates :orientation, presence: true
  validate :validate_position
  validate :validate_values

  scope :column_clues, -> { where(orientation: Clue.orientations[:column]).order(:position) }
  scope :row_clues, -> { where(orientation: Clue.orientations[:row]).order(:position) }

  def validate_position
    unless position < game.board_size
      errors.add(:position, 'outside of grid')
    end
  end

  def validate_values
    # values are comma seperated
    unless values.all? { |value| value.kind_of? Integer }
      errors.add(:values, 'values should be integers')
    end
  end

  def values
    read_attribute(:values).split(',').map(&:to_i)
  end

  def values=(values_array)
    super(values_array.map(&:to_i).join(','))
  end
end
