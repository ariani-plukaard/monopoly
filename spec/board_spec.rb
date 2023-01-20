require 'board'
require 'board_space'
require 'player'

describe Board do
  let(:board_string) do
    JSON.generate([
      {
        name: 'GO',
        type: 'go'
      },
      {
        name: 'The Burvale',
        price: 1,
        colour: 'Brown',
        type: 'property'
      }
    ])
  end

  let(:players_array) { ['Player1', 'Player2'] }
  let(:board) { Board.new(board_string, players_array) }

  context 'instance initialized with players and board spaces' do
    it 'has array of properties (& go)' do
      expect(board.board_spaces).to all(be_a(BoardSpace))
    end
    it 'has array of players' do
      expect(board.players).to all(be_a(Player))
    end
  end
end
