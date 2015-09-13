require 'rails_helper'

RSpec.describe CheckAnswer do
  let(:board_size) { 5 }
  let(:board) { Board.create!(board_size: board_size) }

  before do
    board.clues.create!(orientation: :column, position: 0, lengths: [1])
    board.clues.create!(orientation: :column, position: 1, lengths: [])
    board.clues.create!(orientation: :column, position: 2, lengths: [3])
    board.clues.create!(orientation: :column, position: 3, lengths: [3])
    board.clues.create!(orientation: :column, position: 4, lengths: [1])
    board.clues.create!(orientation: :row, position: 0, lengths: [1])
    board.clues.create!(orientation: :row, position: 1, lengths: [1])
    board.clues.create!(orientation: :row, position: 2, lengths: [2])
    board.clues.create!(orientation: :row, position: 3, lengths: [1])
    board.clues.create!(orientation: :row, position: 4, lengths: [1,1,1])
  end

  it 'checks a correct answer' do
    answer = [
      {column: 0, row: 4},
      {column: 2, row: 2},
      {column: 2, row: 3},
      {column: 2, row: 4},
      {column: 3, row: 0},
      {column: 3, row: 1},
      {column: 3, row: 2},
      {column: 4, row: 4},
    ]

    grid = Grid.new(size: board.board_size).from_answer(answer).grid

    expect(CheckAnswer.new(board: board, grid: grid).call).to be true
  end

  it 'checks an incorrect answer' do
    answer = [
      {column: 0, row: 4},
      {column: 2, row: 2},
    ]

    grid = Grid.new(size: board.board_size).from_answer(answer).grid

    expect(CheckAnswer.new(board: board, grid: grid).call).to be false
  end
end
