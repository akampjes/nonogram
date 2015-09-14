require 'rails_helper'

RSpec.describe Clue, type: :model do
  let(:puzzle) { Puzzle.create!(board_size: 5) }
  subject(:clue) { puzzle.clues.new }

  
  # see Shoulda Matchers
  # it { is_expected.to validate_presence_of :foo }
  # it { should validate_presence_of :foo }

  describe '#lengths' do
    it 'is set with an array of lengths' do
      lengths = [1,2,3]
      clue.lengths = lengths

      expect(clue.lengths).to eq lengths
    end
  end
end
