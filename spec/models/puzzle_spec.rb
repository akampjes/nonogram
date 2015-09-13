require 'rails_helper'

RSpec.describe Puzzle, type: :model do
  describe '#board_size' do
    it 'is a number' do
      subject.board_size = 5
      expect(subject).to be_valid
    end

    context 'invalid board_size when' do
      it 'is less than five' do
        subject.board_size = 4
        expect(subject).to be_invalid
      end

      it 'is not a number' do
        subject.board_size = 'a'
        expect(subject).to be_invalid
      end
    end
  end
end