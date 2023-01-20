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
  let(:players_array) { [player1, {name: 'Player2'}, {name: 'Player3'}] }
  let(:player1) { {name:'Player1'} }
  let(:board) { Board.new(board_string, players_array) }

  context 'instance initialized with players and board spaces' do
    it 'has array of properties (& go)' do
      expect(board.board_spaces).to all(be_a(BoardSpace))
    end
    it 'has array of players' do
      expect(board.players).to all(be_a(Player))
    end
  end

  describe '#make_turn' do
    context "given it's player1's turn and they were on position 2" do
      let(:player1) { {name:'Player1', position: 2} }
      context 'given player1 has rolled a 3' do
        it "updates player1's position to 0 (Go)" do
          board.make_turn(3)
          expect(board.players[0].position).to eq(0)
        end
        it "adds 1 to player1's money for passing Go" do
          board.make_turn(3)
          expect(board.players[0].money).to eq(17)
        end
      end
      context 'given player1 has rolled a 2' do
        it "updates player1's position to 4" do
          board.make_turn(2)
          expect(board.players[0].position).to eq(4)
        end
        it "no change to player1's money (did not pass Go)" do
          board.make_turn(2)
          expect(board.players[0].money).to eq(16)
        end
      end
    end
  end

  # describe '#double_rent?' do
  #   context 'all blue properties are owned by the same owner' do
  #     board.board_spaces[1].add_owner(board)
  #     it 'returns true' do

  #     end
  #   end
  #   context 'blue properties are owned by different owners' do
  #     it 'returns false' do

  #     end
  #   end
  #   context 'not all blue properties are owned' do
  #     it 'returns false' do

  #     end
  #   end
  # end
end
