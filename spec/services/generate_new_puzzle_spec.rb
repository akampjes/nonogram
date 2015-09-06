require 'rails_helper'

RSpec.describe GenerateNewPuzzle, type: :service do
  let(:board_size) { 5 }
  let(:game) { Game.create!(board_size: board_size) }

  it 'generates creates clues' do
    srand(1)

    expect {
      GenerateNewPuzzle.new(game: game).call
    }.to change { Clue.count }.by 2*board_size
  end

end
