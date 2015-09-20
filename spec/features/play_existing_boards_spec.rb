require 'rails_helper'

RSpec.feature "PlayExistingPuzzles", type: :feature do
  # We use before here because it needs to be loaded for
  # the views to work
  before do
    @puzzle = Puzzle.create!(board_size: 5)
    GenerateCluesOnPuzzle.new(puzzle: @puzzle).call
  end

  scenario 'Select existing puzzle' do

    visit puzzles_path
    expect(page).to have_content 'Puzzles'

    click_on "puzzle #{@puzzle.id}"

    expect(current_path).to eq puzzle_path(@puzzle)
  end
end
