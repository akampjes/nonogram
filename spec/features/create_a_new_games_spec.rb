require 'rails_helper'

RSpec.feature "CreateANewGame", type: :feature do
  scenario 'new game' do
    visit games_path
    expect(page).to have_content 'Games'

    click_on 'Create game'
    fill_in 'Board size', with: '5'
    click_on 'Create'

    expect(current_path).to eq game_path(Game.last)
  end
end
