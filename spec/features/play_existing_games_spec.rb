require 'rails_helper'

RSpec.feature "PlayExistingGames", type: :feature do
  # We use before here because it needs to be loaded for
  # the views to work
  before do
    @game = Game.create!(board_size: 5)
  end

  scenario 'Select existing game' do

    visit games_path
    expect(page).to have_content 'Games'

    click_on "game #{@game.id}"

    expect(current_path).to eq game_path(@game)
  end
end
