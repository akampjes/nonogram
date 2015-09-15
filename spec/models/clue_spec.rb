require 'rails_helper'

RSpec.describe Clue, type: :model do
  let!(:puzzle) { Puzzle.create!(board_size: 5) }
  subject(:clue) { Clue.new(orientation: :row, position: 1, puzzle: puzzle) }

  it  { is_expected.to validate_presence_of :orientation }
  it  { is_expected.to validate_presence_of :puzzle }

  describe '#legend' do
    it 'is set with an array of legend' do
      legend = [1,2,3]
      clue.legend = legend

      expect(clue.legend).to eq legend
    end
  end
end
