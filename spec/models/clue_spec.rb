require 'rails_helper'

RSpec.describe Clue, type: :model do
  let(:game) { Game.create!(board_size: 5) }
  subject(:clue) { game.clues.new() }

  describe '#values' do
    it 'it is set with an array of values' do
      a = [1,2,3]
      subject.values = a

      expect(subject.values).to eq a
    end
  end
end
