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
  let(:players_array) { [player1, player2, player3] }
  let(:player1) { {name:'Player1'} }
  let(:player2) { {name:'Player2'} }
  let(:player3) { {name:'Player3'} }
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
    context "it's player1's turn and they were on position 2" do
      let(:player1) { {name:'Player1', position: 2} }
      context 'given player1 rolled a 3' do
        it "update player1's position to 0 (Go)" do
          board.make_turn(3)
          expect(board.players[0].position).to eq(0)
        end
        it "add 1 to player1's money for passing Go" do
          board.make_turn(3)
          expect(board.players[0].money).to eq(17)
        end
      end

      context 'given player1 rolled a 2' do
        it "updates player1's position to 4 (not pass Go)" do
          board.make_turn(2)
          expect(board.players[0].position).to eq(4)
        end
        context 'given player1 already owns the property at position 4' do
          it "no change to player1's money" do
            board.board_spaces[4].add_owner(board.players[0])
            board.make_turn(2)
            expect(board.players[0].money).to eq(16)
          end
        end
      end
    end

    context "it's player1's turn and they were on position 0" do
      context 'given player1 rolls and moves to position 2 (not pass go)' do
        let(:have_turn) { board.make_turn(2) }
        context 'given the property is not owned' do
          it 'updates owner of the property to be player1' do
            have_turn
            expect(board.board_spaces[2].owner).to eq(board.players[0])
          end
          it "subtracts 2, the cost of the property, from player1's money" do
            have_turn
            expect(board.players[0].money).to eq(14)
          end
        end

        context 'given this property is owned by player2' do
          let(:player2_owns_property2) { board.board_spaces[2].add_owner(board.players[1]) }
          it 'makes no change to the property ownership' do
            player2_owns_property2
            have_turn
            expect(board.board_spaces[2].owner).to eq(board.players[1])
          end

          context 'when all properties of this blue colour are owned by player2' do
            let(:player2_owns_property1) { board.board_spaces[1].add_owner(board.players[1]) }
            it "subtracts 4, double the cost of the property, from player1's money as rent" do
              player2_owns_property1
              player2_owns_property2
              have_turn
              expect(board.players[0].money).to eq(12)
            end
            it "adds the rent to player2's money" do
              player2_owns_property1
              player2_owns_property2
              have_turn
              expect(board.players[1].money).to eq(20)
            end
          end

          context 'when the other property of this blue colour is owned by player3' do
            let(:player3_owns_property1) { board.board_spaces[1].add_owner(board.players[2]) }
            it "subtracts 2, the cost of the property, from player1's money as rent" do
              player3_owns_property1
              player2_owns_property2
              have_turn
              expect(board.players[0].money).to eq(14)
            end
            it "adds the rent to player2's money" do
              player3_owns_property1
              player2_owns_property2
              have_turn
              expect(board.players[1].money).to eq(18)
            end
          end
          context 'when not all properties of this blue colour are owned' do
            it "subtracts 2, the cost of the property, from player1's money as rent" do
              player2_owns_property2
              have_turn
              expect(board.players[0].money).to eq(14)
            end
            it "adds the rent to player2's money" do
              player2_owns_property2
              have_turn
              expect(board.players[1].money).to eq(18)
            end
          end
        end
      end
    end
  end

  describe '#next_player' do
    context 'there are 3 players starting with player1' do
      context 'the active player was player1' do
        it 'the next player is player2' do
          expect(board.next_player).to eq(board.players[1])
        end
      end
      context 'the active player was player3' do
        it 'the next player is player1' do
          board.next_player
          board.next_player
          expect(board.next_player).to eq(board.players[0])
        end
      end
    end
  end

  describe '#results' do
    context 'player1 is bankrupt and player2 has the most money' do
      let(:player1) { {name:'Player1', money: -1, position: 1} }
      let(:player2) { {name:'Player2', money: 30, position: 3} }
      let(:player3) { {name:'Player3', money: 15, position: 0} }
      it 'returns results with player2 as the winner, followed by player3 and player1' do
        expect(board.results).to eq([
          {
            player: "Player2",
            money: 30,
            final_position: "Myer"
          },
          {
            player: "Player3",
            money: 15,
            final_position: "GO"
          },
          {
            player: "Player1",
            money: -1,
            final_position: "Kmart"
          }
        ])
      end
    end
  end
end
