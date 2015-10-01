require 'rails_helper'

RSpec.describe CheckSolution do
  let(:board_size) { 5 }
  let(:puzzle) { Puzzle.create!(board_size: board_size) }

  before do
    legends = []
    legends << puzzle.legends.new(orientation: :column, position: 0)
    legends << puzzle.legends.new(orientation: :column, position: 1)
    legends << puzzle.legends.new(orientation: :column, position: 2)
    legends << puzzle.legends.new(orientation: :column, position: 3)
    legends << puzzle.legends.new(orientation: :column, position: 4)
    legends << puzzle.legends.new(orientation: :row, position: 0)
    legends << puzzle.legends.new(orientation: :row, position: 1)
    legends << puzzle.legends.new(orientation: :row, position: 2)
    legends << puzzle.legends.new(orientation: :row, position: 3)
    legends << puzzle.legends.new(orientation: :row, position: 4)

    legends[0].clues.new(legend: legends[0], position: 0, contiguous_boxes: 1, color: '1').save!
    legends[2].clues.new(legend: legends[2], position: 0, contiguous_boxes: 3, color: '1').save!
    legends[3].clues.new(legend: legends[3], position: 0, contiguous_boxes: 3, color: '1').save!
    legends[4].clues.new(legend: legends[4], position: 0, contiguous_boxes: 1, color: '1').save!
    legends[5].clues.new(legend: legends[5], position: 0, contiguous_boxes: 1, color: '1').save!
    legends[6].clues.new(legend: legends[6], position: 0, contiguous_boxes: 1, color: '1').save!
    legends[7].clues.new(legend: legends[7], position: 0, contiguous_boxes: 2, color: '1').save!
    legends[8].clues.new(legend: legends[8], position: 0, contiguous_boxes: 1, color: '1').save!
    legends[9].clues.new(legend: legends[9], position: 0, contiguous_boxes: 1, color: '1').save!
    legends[9].clues.new(legend: legends[9], position: 1, contiguous_boxes: 1, color: '1').save!
    legends[9].clues.new(legend: legends[9], position: 2, contiguous_boxes: 1, color: '1').save!
  end

  it 'checks a correct solution' do
    boxes = [
      Cell.new(column: 0, row: 4, color: '1'),
      Cell.new(column: 2, row: 2, color: '1'),
      Cell.new(column: 2, row: 3, color: '1'),
      Cell.new(column: 2, row: 4, color: '1'),
      Cell.new(column: 3, row: 0, color: '1'),
      Cell.new(column: 3, row: 1, color: '1'),
      Cell.new(column: 3, row: 2, color: '1'),
      Cell.new(column: 4, row: 4, color: '1'),
    ]

    board = Board.new(size: puzzle.board_size).from_cells(boxes)

    expect(CheckSolution.new(puzzle: puzzle, board: board).call).to be true
  end

  it 'checks an incorrect solution' do
    boxes = [
      Cell.new(column: 0, row: 4, color: 'meh'),
      Cell.new(column: 2, row: 2, color: 'heh'),
    ]

    board = Board.new(size: puzzle.board_size).from_cells(boxes)

    expect(CheckSolution.new(puzzle: puzzle, board: board).call).to be false
  end
end
