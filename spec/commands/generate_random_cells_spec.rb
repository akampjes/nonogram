require 'rails_helper'

RSpec.describe GenerateRandomCells do
  subject(:board) { Board.new(size: 5) }
  it 'handles empty answers' do
    rows = Board.new(size: 5, cells: []).rows

    expect(rows).to be_kind_of Array
  end

  it 'creates random sets of cells' do
    srand(1)
    cells1 = GenerateRandomCells.new(board_size: 5, max_colors: 3).call
    cells2 = GenerateRandomCells.new(board_size: 5, max_colors: 3).call

    expect(cells1).not_to match_array cells2
  end
end
