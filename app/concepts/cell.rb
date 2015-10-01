class Cell
  include ActiveModel::Validations

  validates :row, :column, numericality: true
  validates :row, :column, presence: true

  attr_reader :row, :column, :color

  def initialize(row:, column:, color:)
    @row = row.to_i
    @column = column.to_i
    @color = color
  end
end