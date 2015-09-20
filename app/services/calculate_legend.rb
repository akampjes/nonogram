class CalculateLegend
  def initialize(line:)
    @line = line
  end

  def call
    count_contigous_boxes
  end

  private

  # Takes an array of bools and returns an array with the lengths of each contigous set of truthy values
  # [true, true, false, false, true, false]
  # => [2, 1]
  def count_contigous_boxes
    @line.split(&:blank?).reject(&:empty?).map(&:count)
  end
end
