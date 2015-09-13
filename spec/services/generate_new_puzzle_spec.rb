require 'rails_helper'

RSpec.describe GenerateNewPuzzle, type: :service do
  let(:board_size) { 5 }
  let(:board) { Board.create!(board_size: board_size) }

  it 'generates creates clues' do
    srand(1)

    expect {
      GenerateNewPuzzle.new(board: board).call
    }.to change { Clue.count }.by 2*board_size
  end

  it 'creates the correct clues' do
    srand(1)

    expected_clues = []
    expected_clues << Clue.new(orientation: :column, position: 0, lengths: [3])
    expected_clues << Clue.new(orientation: :column, position: 1, lengths: [1,1])
    expected_clues << Clue.new(orientation: :column, position: 2, lengths: [3,1])
    expected_clues << Clue.new(orientation: :column, position: 3, lengths: [2,1])
    expected_clues << Clue.new(orientation: :column, position: 4, lengths: [1,2])
    expected_clues << Clue.new(orientation: :row, position: 0, lengths: [1,3])
    expected_clues << Clue.new(orientation: :row, position: 1, lengths: [4])
    expected_clues << Clue.new(orientation: :row, position: 2, lengths: [1,1,1])
    expected_clues << Clue.new(orientation: :row, position: 3, lengths: [1,2])
    expected_clues << Clue.new(orientation: :row, position: 4, lengths: [1])

    GenerateNewPuzzle.new(board: board).call

    expect(board.clues).to match_clue_array expected_clues
  end

  context 'board clues are supposed to be random' do
    it 'creates random clues' do
      srand(1)
      board2 = Board.create!(board_size: board_size)

      GenerateNewPuzzle.new(board: board).call
      GenerateNewPuzzle.new(board: board2).call

      expect(board.clues).not_to match_clue_array board2.clues
    end
  end
end
