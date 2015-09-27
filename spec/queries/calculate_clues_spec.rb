require 'rails_helper'

RSpec.describe CalculateClues do
  it 'works out the correct lengths' do
    line = ['', '1', '1', '', '1']
    expect(CalculateClues.new(line: line).call.map(&:to_json)).to eq [
      Clue.new(contiguous_boxes: 2, color: '1', position: 0),
      Clue.new(contiguous_boxes: 1, color: '1', position: 1)
    ].map(&:to_json)
  end

  it 'handles different colors' do
    line = ['', '3', '3', '', '2']

    expect(CalculateClues.new(line: line).call.map(&:to_json)).to eq [
      Clue.new(contiguous_boxes: 2, color: '3', position: 0),
      Clue.new(contiguous_boxes: 1, color: '2', position: 1)
    ].map(&:to_json)
  end

  it 'handles different colors next to each other' do
    line = ['', '3', '1', '1', '2']

    expect(CalculateClues.new(line: line).call.map(&:to_json)).to eq [
      Clue.new(contiguous_boxes: 1, color: '3', position: 0),
      Clue.new(contiguous_boxes: 2, color: '1', position: 1),
      Clue.new(contiguous_boxes: 1, color: '2', position: 2)
    ].map(&:to_json)
  end


  it 'handles empty lines' do
    line = []
    expect(CalculateClues.new(line: line).call).to eq []
  end

  it 'handles no lengths' do
    line = ['', '', '']
    expect(CalculateClues.new(line: line).call).to eq []
  end
end
