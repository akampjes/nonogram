require 'rails_helper'

RSpec.describe GenerateCluesOnPuzzle, type: :service do
  let(:board_size) { 5 }
  let(:puzzle) { Puzzle.create!(board_size: board_size) }

  it 'generates creates clues' do
    srand(1)

    expect {
      GenerateCluesOnPuzzle.new(puzzle: puzzle).call
    }.to change { Clue.count }.by 2*board_size
  end

  it 'creates the correct clues' do
    srand(1)

    expected_clues = []
    expected_clues << Clue.new(orientation: :column, position: 0, legend: [3])
    expected_clues << Clue.new(orientation: :column, position: 1, legend: [1,1])
    expected_clues << Clue.new(orientation: :column, position: 2, legend: [3,1])
    expected_clues << Clue.new(orientation: :column, position: 3, legend: [2,1])
    expected_clues << Clue.new(orientation: :column, position: 4, legend: [1,2])
    expected_clues << Clue.new(orientation: :row, position: 0, legend: [1,3])
    expected_clues << Clue.new(orientation: :row, position: 1, legend: [4])
    expected_clues << Clue.new(orientation: :row, position: 2, legend: [1,1,1])
    expected_clues << Clue.new(orientation: :row, position: 3, legend: [1,2])
    expected_clues << Clue.new(orientation: :row, position: 4, legend: [1])

    GenerateCluesOnPuzzle.new(puzzle: puzzle).call

    expect(puzzle.clues).to match_clue_array expected_clues
  end

  context 'puzzle clues are supposed to be random' do
    it 'creates random clues' do
      srand(1)
      puzzle2 = Puzzle.create!(board_size: board_size)

      GenerateCluesOnPuzzle.new(puzzle: puzzle).call
      GenerateCluesOnPuzzle.new(puzzle: puzzle2).call

      expect(puzzle.clues).not_to match_clue_array puzzle2.clues
    end
  end
end
