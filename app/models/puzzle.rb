class Puzzle < ActiveRecord::Base
  DEFAULT_BOARD_SIZE = 5
  DEFAULT_MAX_COLORS = 1

  has_many :legends, dependent: :destroy

  after_initialize :default_values

  validates :board_size, numericality: { greater_than_or_equal_to: DEFAULT_BOARD_SIZE }
  validates :max_colors, numericality: { greater_than_or_equal_to: DEFAULT_MAX_COLORS }

  def default_values
    self.board_size ||= DEFAULT_BOARD_SIZE
    self.max_colors ||= DEFAULT_MAX_COLORS
  end
end
