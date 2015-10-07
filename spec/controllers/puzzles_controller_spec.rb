require 'rails_helper'

RSpec.describe PuzzlesController, type: :controller do
  let!(:puzzle) { Puzzle.create(board_size: 5) }
  let(:board) { Board.new(size: puzzle.board_size, cells: GenerateRandomCells.new(board_size: puzzle.board_size, number_of_colors: 2).call) }
  let(:valid_params) { { boxes: [{row: 0, column: 0}, {row: 0, column: 2}, {row: 0, column: 4}], id: puzzle.id } }

  before do
    GenerateLegendsOnPuzzle.new(puzzle: puzzle, board: board).call
  end

  describe 'POST #check_solution' do
    it 'takes a POST and returns JSON' do
      post :check_solution, valid_params, format: :json

      result = JSON.parse(response.body)
      expect(result["won"]).to_not be nil
      expect(result["message"]).to_not be nil
    end
  end
end
