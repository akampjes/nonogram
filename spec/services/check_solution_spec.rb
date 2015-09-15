require 'rails_helper'

RSpec.describe CheckSolution do
  let(:board_size) { 5 }
  let(:puzzle) { Puzzle.create!(board_size: board_size) }

  before do
    puzzle.clues.create!(orientation: :column, position: 0, legend: [1])
    puzzle.clues.create!(orientation: :column, position: 1, legend: [])
    puzzle.clues.create!(orientation: :column, position: 2, legend: [3])
    puzzle.clues.create!(orientation: :column, position: 3, legend: [3])
    puzzle.clues.create!(orientation: :column, position: 4, legend: [1])
    puzzle.clues.create!(orientation: :row, position: 0, legend: [1])
    puzzle.clues.create!(orientation: :row, position: 1, legend: [1])
    puzzle.clues.create!(orientation: :row, position: 2, legend: [2])
    puzzle.clues.create!(orientation: :row, position: 3, legend: [1])
    puzzle.clues.create!(orientation: :row, position: 4, legend: [1,1,1])
  end

  it 'checks a correct solution' do
    boxes = [
      {column: 0, row: 4},
      {column: 2, row: 2},
      {column: 2, row: 3},
      {column: 2, row: 4},
      {column: 3, row: 0},
      {column: 3, row: 1},
      {column: 3, row: 2},
      {column: 4, row: 4},
    ]

    board = Board.new(size: puzzle.board_size).from_boxes(boxes)

    expect(CheckSolution.new(puzzle: puzzle, board: board).call).to be true
  end

  it 'checks an incorrect solution' do
    boxes = [
      {column: 0, row: 4},
      {column: 2, row: 2},
    ]

    board = Board.new(size: puzzle.board_size).from_boxes(boxes)

    expect(CheckSolution.new(puzzle: puzzle, board: board).call).to be false
  end
end
