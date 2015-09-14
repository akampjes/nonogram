require 'rails_helper'

RSpec.describe Board do
  subject(:board) { Board.new(size: 5) }

  it 'populates a board an array of selected tiles' do
    boxes = [{column: 2, row: 1}, {column: 1, row:1}]
    answer_board = board.from_boxes(boxes).row_lines

    expect(answer_board[1][2]).to be true
    expect(answer_board[1][1]).to be true
    expect(answer_board[2][1]).to_not be true
  end

  it 'handles nil answers' do
    lines = board.from_boxes(nil).row_lines

    expect(lines).to be_kind_of Array
  end

  context 'board is able to randomyly populate itself' do
    it 'populates boards differently' do
      srand(1)
      board1 = Board.new(size: 5).randomly_populate!
      board2 = Board.new(size: 5).randomly_populate!

      expect(board1.row_lines).not_to match_array board2.row_lines
    end
  end
end
