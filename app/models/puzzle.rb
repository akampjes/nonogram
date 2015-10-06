class Puzzle < ActiveRecord::Base
  DEFAULT_BOARD_SIZE = 5
  DEFAULT_MAX_COLORS = 1
  MAXIMUM_COLORS = 5
  MINIMUM_BOARD_SIZE = 5

  has_many :legends, dependent: :destroy

  after_initialize :default_values

  validates :board_size, numericality: { greater_than_or_equal_to: MINIMUM_BOARD_SIZE}
  validates :max_colors, numericality: { greater_than: 0}
  validates :max_colors, numericality: { less_than_or_equal_to: MAXIMUM_COLORS}

  def default_values
    self.board_size ||= DEFAULT_BOARD_SIZE
    self.max_colors ||= DEFAULT_MAX_COLORS
  end
end
