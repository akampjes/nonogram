require 'rails_helper'

RSpec.describe Clue, type: :model do
  let(:board) { Board.create!(board_size: 5) }
  subject(:clue) { board.clues.new() } # brackets?

  # I could probably add some more tests here

  describe '#lengths' do
    it 'is set with an array of lengths' do
      lengths = [1,2,3]
      subject.lengths = lengths

      expect(subject.lengths).to eq lengths
    end
  end
end
