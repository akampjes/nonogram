require 'rails_helper'

RSpec.feature "PlayExistingPuzzles", type: :feature do
  # We use before here because it needs to be loaded for
  # the views to work
  before do
    @puzzle = Puzzle.create!(board_size: 5)
    board = RandomlyPopulateBoard.new(board: Board.new(size: @puzzle.board_size), max_colors: @puzzle.max_colors).call
    GenerateLegendsOnPuzzle.new(puzzle: @puzzle, board: board).call

  end

  scenario 'Select existing puzzle' do

    visit puzzles_path
    expect(page).to have_content 'Puzzles'

    click_on "puzzle #{@puzzle.id}"

    expect(current_path).to eq puzzle_path(@puzzle)
  end
end
