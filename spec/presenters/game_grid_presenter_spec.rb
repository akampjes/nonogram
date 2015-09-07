require 'rails_helper'

RSpec.describe GameGridPresenter do
  let(:board_size) { 5 }
  let(:game) { Game.create!(board_size: board_size) }

  it 'is an Array of Arrays of Tiles' do
    # Should look something like:
    # [ [Tile, Tile], [Tile, Tile] ]

    GenerateNewPuzzle.new(game: game).call
    presented_game = GameGridPresenter.new(game)

    expect(presented_game.rows).to be_kind_of Array
    
    presented_game.rows.each do |row|
      expect(row).to be_kind_of Array

      row.each do |tile|
        expect(tile).to be_kind_of Tile
      end
    end
  end
end
