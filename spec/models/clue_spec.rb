require 'rails_helper'

RSpec.describe Clue, type: :model do
  let(:game) { Game.create!(board_size: 5) }
  subject(:clue) { game.clues.new() }

  describe '#lengths' do
    it 'it is set with an array of lengths' do
      a = [1,2,3]
      subject.lengths = a

      expect(subject.lengths).to eq a
    end
  end
end
