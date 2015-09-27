class CalculateClues
  # I could rename line to something like `row_or_column`
  def initialize(line:)
    @line = line
  end

  def call
    count_contiguous_boxes
  end

  private

  def count_contiguous_boxes
    @line
      .chunk { |color| color }
      .reject { |color, _| color.blank? }
      .map.with_index do |color_group, position|
        color, occurrences = color_group
        Clue.new(contiguous_boxes: occurrences.count, color: color, position: position)
      end
  end
end
