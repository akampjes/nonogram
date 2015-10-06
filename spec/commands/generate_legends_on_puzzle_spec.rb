require 'rails_helper'

RSpec.describe GenerateLegendsOnPuzzle, type: :service do
  let(:board_size) { 5 }
  let(:puzzle) { Puzzle.create!(board_size: board_size) }
  let(:board) { Board.new(size: puzzle.board_size, cells: GenerateRandomCells.new(board_size: puzzle.board_size, max_colors: puzzle.max_colors).call) }

  it 'generates creates legends' do
    srand(1)

    expect {
      GenerateLegendsOnPuzzle.new(puzzle: puzzle, board: board).call
    }.to change { Legend.count }.by 2*board_size
  end

  xit 'creates the correct legends' do
    pending 'skip and find a better place to test clues'

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

    GenerateLegendsOnPuzzle.new(puzzle: puzzle, board: board).call

    expect(puzzle.legends).to match_legend_array expected_legends
  end

  it 'saves clues' do
    srand(1)

    expect { GenerateLegendsOnPuzzle.new(puzzle: puzzle, board: board).call }.to change { Clue.count }
  end
end
