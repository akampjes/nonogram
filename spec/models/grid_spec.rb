require 'rails_helper'

RSpec.describe Grid do
  subject(:grid) { Grid.new(size: 5) }
  it 'randomly populates a board' do
    result1 = grid.randomly_populate!
    result2 = Grid.new(size: 5).randomly_populate!

    expect(result1).to_not eq result2
  end
end
