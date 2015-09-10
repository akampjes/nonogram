require 'rails_helper'

RSpec.describe Grid do
  subject(:grid) { Grid.new(size: 5) }
  it 'randomly populates a board' do
    result1 = grid.randomly_populate!
    result2 = Grid.new(size: 5).randomly_populate!

    expect(result1).to_not eq result2
  end

  it 'populates a grid an array of selected tiles' do
    answer = [{column: 2, row: 1}, {column: 1, row:1}]
    answer_grid = grid.from_answer(answer).grid

    expect(answer_grid[1][2]).to be true
    expect(answer_grid[1][1]).to be true
    expect(answer_grid[2][1]).to_not be true
  end
end
