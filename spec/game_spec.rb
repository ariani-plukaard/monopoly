require 'game'

describe 'game' do
  describe '#run_game' do
    let(:players) {[player1, player2, player3]}
    let(:player1) {{ name: 'Player1' }}
    let(:player2) {{ name: 'Player2' }}
    let(:player3) {{ name: 'Player3' }}
    context 'game is run without a command-line argument' do
      let(:rolls_file) {nil}
      it "game doesn't run" do
        expect(run_game(rolls_file, players)).to eq(false)
      end
    end
    context 'game is run with a command-line argument that is not json filename' do
      let(:rolls_file) {'blah.rb'}
      it "game doesn't run" do
        expect(run_game(rolls_file, players)).to eq(false)
      end
    end
    context 'game is run with a json file for rolls in command-line argument' do
      let(:rolls_file) {'spec/test_data/test_rolls.json'}
      let(:rolls) {read_rolls(rolls_file)}
      it "game runs" do
        expect(run_game(rolls_file, players)).to eq(true)
      end
      describe '#read_rolls' do
        it 'returns array of rolls' do
          expect(rolls).to eq([3, 2, 3, 2, 2, 1, 2])
        end
      end
      describe '#simulate_game' do
        let(:board_string) {File.read('spec/test_data/test_board.json')}
        context 'a player is bankrupt before all rolls are made' do
          let(:player1) {{ name: 'Player1', money: 6 }}
          let(:player2) {{ name: 'Player2', money: 6 }}
          let(:player3) {{ name: 'Player3', money: 6 }}
          it 'returns the expected outcome for the game' do
            expect(simulate_game(rolls, board_string, players)).to eq([
              {
                player: 'Player1',
                money: 7,
                final_position: "GO"
              },
              {
                player: 'Player2',
                money: 4,
                final_position: "David Jones"
              },
              {
                player: 'Player3',
                money: -1,
                final_position: "David Jones"
              }
            ])
          end
        end
        context 'no players are bankrupt after all rolls are made' do
          it 'returns the expected outcome for the game' do
            expect(simulate_game(rolls, board_string, players)).to eq([
              {
                player: 'Player2',
                money: 16,
                final_position: "David Jones"
              },
              {
                player: 'Player1',
                money: 15,
                final_position: "Big W"
              },
              {
                player: 'Player3',
                money: 9,
                final_position: "David Jones"
              }
            ])
          end
        end
      end
    end
  end
end
