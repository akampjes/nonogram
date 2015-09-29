class Puzzle < ActiveRecord::Base
  DEFAULT_BOARD_SIZE = 5
  DEFAULT_MAX_COLORS = 1

  has_many :legends, dependent: :destroy

  # would rather not have database initilize the constants and do it in the model

  validates :board_size, numericality: { greater_than_or_equal_to: DEFAULT_BOARD_SIZE }
  validates :max_colors, numericality: { greater_than_or_equal_to: DEFAULT_MAX_COLORS }
end
