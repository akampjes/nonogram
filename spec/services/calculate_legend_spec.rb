require 'rails_helper'

RSpec.describe CalculateLegend do
  it 'works out the correct lengths' do
    line = [false, true, true, false, true]
    expect(CalculateLegend.new(line: line).call).to eq [2, 1]
  end

  it 'handles empty lines' do
    line = []
    expect(CalculateLegend.new(line: line).call).to eq []
  end

  it 'handles no lengths' do
    line = [false, false, false]
    expect(CalculateLegend.new(line: line).call).to eq []
  end
end
