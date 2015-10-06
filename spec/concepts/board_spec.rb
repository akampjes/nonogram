require 'rails_helper'

RSpec.describe Board do
  subject(:board) { Board.new(size: 5) }

  it 'populates a board an array of selected cells' do
    boxes = [Cell.new(column: 2, row: 1, color: '1'), Cell.new(column: 1, row:1, color: '1')]
    answer_board = Board.new(size: 5, cells: boxes).rows

    expect(answer_board[1][2]).to eq '1'
    expect(answer_board[1][1]).to eq '1'
    expect(answer_board[2][1]).to be_nil
  end

  it 'handles boards without cells' do
    lines = board.rows

    expect(lines).to be_kind_of Array
  end
end
