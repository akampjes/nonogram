require 'rails_helper'

RSpec.feature "NewBoardDisplays", type: :feature do
  let(:board_size) { 5 }
  let(:game) { Game.create!(board_size: board_size) }

  before do
    srand(1)
    GenerateNewPuzzle.new(game: game).call
  end

  scenario 'Display an empty board upon visiting' do
    visit(game_path(game))

    expect(page).to have_content "Game ##{game.id}"
    expect(page).to have_css '.play_tile', count: board_size*board_size
  end

  scenario 'Display has a bunch of clues' do
    visit(game_path(game))

    expect(page).to have_content "Game ##{game.id}"
    expect(page).to have_css '.clue_tile'
  end
end
