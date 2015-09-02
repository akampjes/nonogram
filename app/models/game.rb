class Game < ActiveRecord::Base
  validates :board_size, numericality: { greater_than_or_equal_to: 5 }
end
