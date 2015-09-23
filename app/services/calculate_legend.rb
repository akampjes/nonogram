# rename this to calculateclues
# maybe generatecluesforroworcolumn
class CalculateLegend
  def initialize(line:)
    @line = line
  end

  def call
    count_contigous_boxes
  end

  private

  def count_contigous_boxes
    legend = []

    color = nil
    contiguous = 0
    @line.each do |cell|
      if cell != color
        legend << Clue.new(contiguous_boxes: contiguous, color: color) unless color.blank?
        color = cell
        contiguous = 0
      end

      contiguous += 1
    end

    if contiguous > 0 && !color.blank?
      legend << Clue.new(contiguous_boxes: contiguous, color: color)
    end

    legend 
  end
end
