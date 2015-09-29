class CalculateClues
  # I could rename line to something like `row_or_column`
  def initialize(line:)
    @line = line
  end

  def call
    @line
      .chunk { |color| color }
      .reject { |color, _| color.blank? }
      .map.with_index do |(color, occurrences), position|
        Clue.new(contiguous_boxes: occurrences.count, color: color, position: position)
      end
  end
end
