require 'rails_helper'

RSpec.feature 'clicking on a tile', js: true do
  let(:board_size) { 5 }

  scenario 'playing through a puzzle' do
    visit puzzles_path
    expect(page).to have_content 'Puzzles'

    click_on 'Create puzzle'
    fill_in 'Board size', with: board_size
    click_on 'Create'

    puzzle = Puzzle.last
    # Do I really care about this case?
    # Or will I find out when the next step fails anyway?
    # Also seems non-threadsafe
    expect(current_path).to eq puzzle_path(puzzle)

    expect(page).to have_content "Puzzle ##{puzzle.id}"
    expect(page).to have_css '.clue-tile'
    expect(page).to have_css '.play-tile', count: board_size*board_size

    expect(page).to have_css 'div[data-column="0"][data-row="0"].play-tile'
    expect(page).to_not have_css 'div[data-column="0"][data-row="0"].play-tile.selected'
    page.find('div[data-column="0"][data-row="0"]').click
    expect(page).to have_css 'div[data-column="0"][data-row="0"].play-tile.selected'

    expect(page.find('p.board-status').text).to be_empty
    click_on 'Submit'
    sleep 1
    expect(page.find('p.board-status').text).to_not be_empty
  end
end
