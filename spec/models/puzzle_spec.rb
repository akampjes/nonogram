require 'rails_helper'

RSpec.describe Puzzle, type: :model do
  describe '#board_size' do
    it 'is a number' do
      subject.board_size = 5
      expect(subject).to be_valid
    end

    it 'defaults to 5' do
      expect(subject.board_size).to eq 5
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

    describe '#max_colors' do
      it 'defaults to 1' do
        expect(subject.max_colors).to eq 1
      end
    end
  end
end
