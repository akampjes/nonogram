class Clue < ActiveRecord::Base
  belongs_to :legend

  validates :legend, presence: true
  validates :position, presence: true
  validates :position, uniqueness: { scope: :legend }
end
