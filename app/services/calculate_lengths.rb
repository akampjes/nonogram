class CalculateLengths
  def initialize(line:)
    @line = line
  end

  def call
    @line.split(&:blank?).reject(&:empty?).map(&:count)
  end
end
