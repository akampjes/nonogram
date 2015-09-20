require 'rails_helper'

RSpec.describe PuzzlesController, type: :controller do
  let!(:puzzle) { Puzzle.create(board_size: 5) }
  let(:valid_params) { { boxes: [{row: 0, column: 0}, {row: 0, column: 2}, {row: 0, column: 4}], id: puzzle.id } }

  before do
    GenerateCluesOnPuzzle.new(puzzle: puzzle).call
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
