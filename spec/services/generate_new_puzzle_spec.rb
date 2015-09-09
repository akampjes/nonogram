require 'rails_helper'

RSpec.describe GenerateNewPuzzle, type: :service do
  let(:board_size) { 5 }
  let(:game) { Game.create!(board_size: board_size) }

  it 'generates creates clues' do
    srand(1)

    expect {
      GenerateNewPuzzle.new(game: game).call
    }.to change { Clue.count }.by 2*board_size
  end

  it 'creates the correct clues' do
    srand(1)

    # This is probably a bit fragile with the forced id field.
    # Maybe a custom matcher would do the trick
    expected_clues = []
    expected_clues << Clue.new(orientation: :column, position: 0, values: [3])
    expected_clues << Clue.new(orientation: :column, position: 1, values: [1,1])
    expected_clues << Clue.new(orientation: :column, position: 2, values: [3,1])
    expected_clues << Clue.new(orientation: :column, position: 3, values: [2,1])
    expected_clues << Clue.new(orientation: :column, position: 4, values: [1,2])
    expected_clues << Clue.new(orientation: :row, position: 0, values: [1,3])
    expected_clues << Clue.new(orientation: :row, position: 1, values: [4])
    expected_clues << Clue.new(orientation: :row, position: 2, values: [1,1,1])
    expected_clues << Clue.new(orientation: :row, position: 3, values: [1,2])
    expected_clues << Clue.new(orientation: :row, position: 4, values: [1])

    GenerateNewPuzzle.new(game: game).call

    expect(game.clues).to match_array expected_clues
  end
end
