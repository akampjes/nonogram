require 'rails_helper'

RSpec.describe Clue, type: :model do
  let(:legend) { Legend.new }

  describe '#legend' do
    it 'must belong to a legend' do
      clue = Clue.new(position: 0)
      expect(clue).to be_invalid

      clue.legend = legend
      expect(clue).to be_valid
    end
  end

  describe '#position' do
    it 'must have a position' do
      clue = Clue.new(legend: legend)
      expect(clue).to be_invalid

      clue.position = 0
      expect(clue).to be_valid
    end
  end

  context 'there may not be overlapping positions on a legend' do
    it 'is invalid' do
      Clue.create!(legend: legend, position: 0)
      clue2 = Clue.new(legend: legend, position: 0)

      expect(clue2).to be_invalid
    end
  end
end
