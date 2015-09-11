class CalculateLengths
  def initialize(line:)
    @line = line
  end

  def call
    calculate_lengths(@line)
  end

  def calculate_lengths(line)
    #line.to_a.split.reject(&:empty?).map(&:count).to_a
    lengths = []

    run = 0
    line.each do |tile|
      if tile
        run += 1
      elsif run > 0
        lengths << run
        run = 0
      end
    end
    lengths << run if run > 0

    lengths
  end
end
