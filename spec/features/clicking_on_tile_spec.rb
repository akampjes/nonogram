require 'rails_helper'

RSpec.feature 'clicking on a tile', js: true do
  scenario 'playing through a game' do
    visit games_path
    expect(page).to have_content 'Games'

    click_on 'Create game'
    fill_in 'Board size', with: '5'
    click_on 'Create'

    game = Game.last
    # Do I really care about this case?
    # Or will I find out when the next step fails anyway?
    # Also seems non-threadsafe
    expect(current_path).to eq game_path(game)

    expect(page).to have_content "Game ##{game.id}"
    expect(page).to have_css '.clue-tile'

    expect(page).to have_css 'div[data-column="0"][data-row="0"].play-tile'
    expect(page).to_not have_css 'div[data-column="0"][data-row="0"].play-tile.selected'
    page.find('div[data-column="0"][data-row="0"]').click
    expect(page).to have_css 'div[data-column="0"][data-row="0"].play-tile.selected'

    expect(page.find('p.game-status').text).to be_empty
    click_on 'Submit'
    expect(page.find('p.game-status').text).to_not be_empty
  end
end
