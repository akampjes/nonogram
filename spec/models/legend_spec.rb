require 'rails_helper'

RSpec.describe Legend, type: :model do
  let!(:puzzle) { Puzzle.create!(board_size: 5) }
  subject(:legend) { Legend.new(orientation: :row, position: 1, puzzle: puzzle) }

  it  { is_expected.to validate_presence_of :orientation }
  it  { is_expected.to validate_presence_of :puzzle }

  describe '#legend' do
    it 'is set with an array of legend' do
      clues = [1,2,3]
      legend.clues = clues

      expect(legend.clues).to eq clues
    end
  end
end
