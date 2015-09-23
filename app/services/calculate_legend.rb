# rename this to calculateclues
# maybe generatecluesforroworcolumn
# # move this to queriest and commands
class CalculateLegend
  def initialize(line:)
    @line = line
  end

  def call
    count_contigous_boxes
  end

  private

  def count_contigous_boxes
    @line
      .chunk { |color| color }
      .reject { |color, _| color.empty? }
      .map { |color, occurences| Clue.new(contiguous_boxes: occurences.count, color: color) }
  end
end
