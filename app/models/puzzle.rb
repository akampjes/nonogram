class Puzzle < ActiveRecord::Base
  has_many :legends

  # todo contastize these numbers
  validates :board_size, numericality: { greater_than_or_equal_to: 5 }
  validates :max_colors, numericality: { greater_than_or_equal_to: 1 }
end
