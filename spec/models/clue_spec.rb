require 'rails_helper'

RSpec.describe Clue, type: :model do
  subject(:puzzle) { Puzzle.create!(board_size: 5) }
  subject(:clue) { puzzle.clues.new }

  # I could probably add some more tests here
  # ... but do they really matter?
  # a lot of the functionalitiy is implict
  # and things just fall apart if that's broken

  describe '#lengths' do
    it 'is set with an array of lengths' do
      lengths = [1,2,3]
      subject.lengths = lengths

      expect(subject.lengths).to eq lengths
    end
  end
end
