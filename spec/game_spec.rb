require 'game'

describe 'game' do
  describe '#run_game' do
    let(:rolls_file) {'blah.json'}
    context 'game is run without a command-line argument' do
      let(:rolls_file) {nil}
      it "game doesn't run" do
        expect(run_game(rolls_file)).to eq(false)
      end
    end
    context 'game is run with a command-line argument that is not json filename' do
      let(:rolls_file) {'blah.rb'}
      it "game doesn't run" do
        expect(run_game(rolls_file)).to eq(false)
      end
    end
    context 'game is run with a json file for rolls in command-line argument' do
      describe '#read_rolls' do
      end
      describe '#simulate_game' do
      end
    end
  end
end
