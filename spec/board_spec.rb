require 'board'
require 'property'
require 'player'

describe Board do
  let(:properties_string) {"[
    {
      'name': 'GO',
      'type': 'go'
    },
    {
      'name': 'The Burvale',
      'price': 1,
      'colour': 'Brown',
      'type': 'property'
    }
  ]"}
  let(:players_array) { ['Player1', 'Player2'] }
  let(:board) { Board.new(properties_string, players_array) }

  context 'instance initialized with players and properties' do
    it 'has array of properties' do
      expect(board.properties).to all(be_a(Property))
    end
    it 'has array of players' do
      expect(board.players).to all(be_a(Player))
    end
  end
end
