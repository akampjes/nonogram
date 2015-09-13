require 'rails_helper'

RSpec.describe Grid do
  subject(:grid) { Grid.new(size: 5) }

  it 'populates a grid an array of selected tiles' do
    selected_tiles = [{column: 2, row: 1}, {column: 1, row:1}]
    answer_grid = grid.from_selected_tiles(selected_tiles).rows

    expect(answer_grid[1][2]).to be true
    expect(answer_grid[1][1]).to be true
    expect(answer_grid[2][1]).to_not be true
  end

  it 'handles nil answers' do
    rows = grid.from_selected_tiles(nil).rows

    expect(rows).to be_kind_of Array
  end

  context 'grid is able to randomyly populate itself' do
    it 'populates grids differently' do
      srand(1)
      grid1 = Grid.new(size: 5).randomly_populate!
      grid2 = Grid.new(size: 5).randomly_populate!

      expect(grid1.rows).not_to match_array grid2.rows
    end
  end
end
