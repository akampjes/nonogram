require 'rails_helper'

RSpec.describe Legend, type: :model do
  let!(:puzzle) { Puzzle.create!(board_size: 5) }
  subject(:legend) { Legend.create!(orientation: :row, position: 1, puzzle: puzzle) }

  it  { is_expected.to validate_presence_of :orientation }
  it  { is_expected.to validate_presence_of :puzzle }

  describe '#clues' do
    it 'may have a bunch of clues' do
      legend.clues.create!(position: 0)
      legend.clues.create!(position: 1)

      expect(legend.clues.count).to eq 2
    end

    it 'returns clues in ascending position order' do
      clue1 = legend.clues.create!(position: 1)
      clue0 = legend.clues.create!(position: 0)

      expect(legend.clues.first).to eq clue0
      expect(legend.clues.second).to eq clue1
    end
  end
end
