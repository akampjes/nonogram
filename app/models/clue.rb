class Clue < ActiveRecord::Base
  belongs_to :legend

  scope :ordered, -> { order(:position) }

  validates :legend, :position, presence: true
  validates :position, uniqueness: { scope: :legend }
end
