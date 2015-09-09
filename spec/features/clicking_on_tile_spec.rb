require 'rails_helper'

RSpec.feature 'clicking on a tile', js: true do
  scenario 'playing through a game' do
    visit games_path
    expect(page).to have_content 'Games'

    click_on 'Create game'
    fill_in 'Board size', with: '5'
    click_on 'Create'

    game = Game.last
    expect(current_path).to eq game_path(game)

    expect(page).to have_content "Game ##{game.id}"
    expect(page).to have_css '.clue_tile'

    expect(page).to have_css 'div[data-column="0"][data-row="0"].play_tile'
    expect(page).to_not have_css 'div[data-column="0"][data-row="0"].play_tile.selected'
    page.find('div[data-column="0"][data-row="0"]').click
    expect(page).to have_css 'div[data-column="0"][data-row="0"].play_tile.selected'
  end
end
