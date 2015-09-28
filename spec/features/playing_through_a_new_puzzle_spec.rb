require 'rails_helper'

RSpec.feature 'play through a new game', js: true do
  let(:board_size) { 5 }
  let(:max_colors) { 3 }

  scenario 'playing through a puzzle' do
    visit puzzles_path
    expect(page).to have_content 'Puzzles'

    click_on 'Create puzzle'
    fill_in 'Board size', with: board_size
    fill_in 'Max colors', with: max_colors
    click_on 'Create'
    # show nick why this fails
    #Puzzle.create!(ee....)

    puzzle = Puzzle.last
    # Do I really care about this case?
    # Or will I find out when the next step fails anyway?
    # Also seems non-threadsafe
    expect(current_path).to eq puzzle_path(puzzle)

    expect(page).to have_content "Puzzle ##{puzzle.id}"
    expect(page).to have_css '.clue-cell'
    expect(page).to have_css '.play-cell', count: board_size*board_size

    expect(page).to have_css 'div[data-column="0"][data-row="0"].play-cell'
    expect(page).to_not have_css 'div[data-column="0"][data-row="0"].play-cell.selected'
    page.find('div[data-column="0"][data-row="0"]').click
    expect(page).to have_css 'div[data-column="0"][data-row="0"].play-cell.selected'

    expect(page).to have_css '.selected-color-picker'
    expect(page).to have_css '.color-picker', count: max_colors

    last_color_picker = page.find('.color-picker:last-child')
    expect(page.find('.selected-color-picker')).to_not eq last_color_picker

    last_color_picker.click

    expect(page.find('.selected-color-picker')).to eq last_color_picker

    expect(page.find('p.board-status').text).to be_empty
    click_on 'Submit'
    sleep 1
    expect(page.find('p.board-status').text).to_not be_empty
  end
end
