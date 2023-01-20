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
        name: 'Kmart',
        price: 1,
        colour: 'Blue',
        type: 'property'
      },
      {
        name: 'Big W',
        price: 2,
        colour: 'Blue',
        type: 'property'
      },
      {
        name: 'Myer',
        price: 3,
        colour: 'Green',
        type: 'property'
      },
      {
        name: 'David Jones',
        price: 4,
        colour: 'Green',
        type: 'property'
      }
    ])
  end
  let(:players_array) { [{name:'Player1'}, {name: 'Player2'}, {name: 'Player3'}] }
  let(:board) { Board.new(board_string, players_array) }

  context 'instance initialized with players and board spaces' do
    it 'has array of properties (& go)' do
      expect(board.board_spaces).to all(be_a(BoardSpace))
    end
    it 'has array of players' do
      expect(board.players).to all(be_a(Player))
    end
  end

  describe '#move_player' do
    let(:players_array) { [{name:'Player1', position: 2}, {name: 'Player2'}, {name: 'Player3'}] }
    let(:board) { Board.new(board_string, players_array) }
    context 'given Player1 (board.players[0]) has rolled a 3 (and was on position 2)' do
      it "updates Player1's position to 0 (Go)" do
        board.move_player(0, 3)
        expect(board.players[0].position).to eq(0)
      end
      it "adds 1 to Player1's money for passing Go" do
        board.move_player(0, 3)
        expect(board.players[0].money).to eq(17)
      end
    end
    context 'given Player1 (board.players[0]) has rolled a 2 (and was on position 2)' do
      it "updates Player1's position to 4" do
        board.move_player(0, 2)
        expect(board.players[0].position).to eq(4)
      end
      it "no change to Player1's money (did not pass Go)" do
        board.move_player(0, 2)
        expect(board.players[0].money).to eq(16)
      end
    end
  end
end
