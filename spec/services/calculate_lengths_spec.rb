require 'rails_helper'

RSpec.describe CalculateLengths do
  it 'works out the correct lengths' do
    line = [nil, true, true, nil, true]
    expect(CalculateLengths.new(line: line).call).to eq [2, 1]
  end

  it 'handles empty lines' do
    line = []
    expect(CalculateLengths.new(line: line).call).to eq []
  end

  it 'handles no lengths' do
    line = [nil, nil, nil]
    expect(CalculateLengths.new(line: line).call).to eq []
  end
end
