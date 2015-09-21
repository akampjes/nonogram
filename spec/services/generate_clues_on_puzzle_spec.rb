require 'rails_helper'

RSpec.describe GenerateCluesOnPuzzle, type: :service do
  let(:board_size) { 5 }
  let(:puzzle) { Puzzle.create!(board_size: board_size) }

  it 'generates creates legends' do
    srand(1)

    expect {
      GenerateCluesOnPuzzle.new(puzzle: puzzle).call
    }.to change { Legend.count }.by 2*board_size
  end

  it 'creates the correct legends' do
    srand(1)

    expected_legends = []
    expected_legends << Legend.new(orientation: :column, position: 0, clues: [3])
    expected_legends << Legend.new(orientation: :column, position: 1, clues: [1,1])
    expected_legends << Legend.new(orientation: :column, position: 2, clues: [3,1])
    expected_legends << Legend.new(orientation: :column, position: 3, clues: [2,1])
    expected_legends << Legend.new(orientation: :column, position: 4, clues: [1,2])
    expected_legends << Legend.new(orientation: :row, position: 0, clues: [1,3])
    expected_legends << Legend.new(orientation: :row, position: 1, clues: [4])
    expected_legends << Legend.new(orientation: :row, position: 2, clues: [1,1,1])
    expected_legends << Legend.new(orientation: :row, position: 3, clues: [1,2])
    expected_legends << Legend.new(orientation: :row, position: 4, clues: [1])

    GenerateCluesOnPuzzle.new(puzzle: puzzle).call

    expect(puzzle.legends).to match_legend_array expected_legends
  end

  context 'puzzle legends are supposed to be random' do
    it 'creates random legends' do
      srand(1)
      puzzle2 = Puzzle.create!(board_size: board_size)

      GenerateCluesOnPuzzle.new(puzzle: puzzle).call
      GenerateCluesOnPuzzle.new(puzzle: puzzle2).call

      expect(puzzle.legends).not_to match_legend_array puzzle2.legends
    end
  end
end
