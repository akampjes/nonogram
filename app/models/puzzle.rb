class Puzzle < ActiveRecord::Base
  has_many :legends

  DEFAULT_BOARD_SIZE = 5
  DEFAULT_MAX_COLORS = 1

  validates :board_size, numericality: { greater_than_or_equal_to: DEFAULT_BOARD_SIZE}
  validates :max_colors, numericality: { greater_than_or_equal_to: DEFAULT_MAX_COLORS}
end
