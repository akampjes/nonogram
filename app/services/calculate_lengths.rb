class CalculateLengths
  def initialize(line:)
    @line = line
  end
  
  # [true, true, false, false, true, false]
  # => [2, 1]
  # Takes an array of bools and returns an array with the lengths of each contigous set of truthy values
  def call
    @line.split(&:blank?).reject(&:empty?).map(&:count)
  end
end
