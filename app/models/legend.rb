class Legend < ActiveRecord::Base
  belongs_to :puzzle
  has_many :clues, dependent: :destroy

  enum orientation: [:row, :column]

  scope :for_columns, -> { where(orientation: orientations[:column]).order(:position) }
  scope :for_rows, -> { where(orientation: orientations[:row]).order(:position) }

  validates :puzzle, :orientation, presence: true
end
