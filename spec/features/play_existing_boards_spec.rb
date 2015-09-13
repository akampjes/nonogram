require 'rails_helper'

RSpec.feature "PlayExistingBoards", type: :feature do
  # We use before here because it needs to be loaded for
  # the views to work
  before do
    @board = Board.create!(board_size: 5)
    GenerateNewPuzzle.new(board: @board).call
  end

  scenario 'Select existing board' do

    visit boards_path
    expect(page).to have_content 'Boards'

    click_on "board #{@board.id}"

    expect(current_path).to eq board_path(@board)
  end
end
