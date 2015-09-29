require 'rails_helper'

RSpec.describe RandomlyPopulateBoard do
  subject(:board) { Board.new(size: 5) }

  it 'populates a board an array of selected cells' do
    boxes = [{column: 2, row: 1, color: '1'}, {column: 1, row:1, color: '1'}]
    answer_board = board.from_boxes(boxes).row_lines

    expect(answer_board[1][2]).to eq '1'
    expect(answer_board[1][1]).to eq '1'
    expect(answer_board[2][1]).to be_nil
  end

  it 'handles nil answers' do
    lines = board.from_boxes(nil).row_lines

    expect(lines).to be_kind_of Array
  end

  context 'board is able to randomyly populate itself' do
    it 'populates boards differently' do
      srand(1)
      board1 = RandomlyPopulateBoard.new(board: Board.new(size: 5), max_colors: 3).call
      board2 = RandomlyPopulateBoard.new(board: Board.new(size: 5), max_colors: 3).call

      expect(board1.row_lines).not_to match_array board2.row_lines
    end
  end
end