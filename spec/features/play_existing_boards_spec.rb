require 'rails_helper'

RSpec.feature "PlayExistingPuzzles", type: :feature do
  # We use before here because it needs to be loaded for
  # the views to work
  before do
    @puzzle = Puzzle.create!(board_size: 5)
    board = Board.new(size: @puzzle.board_size, cells: GenerateRandomCells.new(board_size: @puzzle.board_size, number_of_colors: 2).call)
    GenerateLegendsOnPuzzle.new(puzzle: @puzzle, board: board).call

  end

  scenario 'Select existing puzzle' do

    visit puzzles_path
    expect(page).to have_content 'Puzzles'

    click_on "puzzle #{@puzzle.id}"

    expect(current_path).to eq puzzle_path(@puzzle)
  end
end
