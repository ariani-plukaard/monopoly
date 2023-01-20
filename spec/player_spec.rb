require 'player'

describe Player do
  let(:player) { Player.new }

  describe '#update_money' do
    context 'given integer 1' do
      it "returns the player's money with 1 added" do
        expect(player.update_money(1)).to eq(17)
      end
    end
    context 'given integer -2' do
      it "returns the player's money with 2 subtracted" do
        expect(player.update_money(-2)).to eq(14)
      end
    end
  end

  describe '#update_position' do
    context 'given player was on position 0' do
      context 'given the roll 3 and board length 9' do
        it "returns the player's position moved 3 spaces to position 3" do
          expect(player.update_position(3, 9)).to eq(3)
        end
      end
    end
    context 'given player was on position 2' do
      context 'given the roll 5 and board length 6' do
        let(:player) { Player.new(position: 2) }
        it "returns the player's position moved 5 spaces to position 1 - board wraps around" do
          expect(player.update_position(5, 6)).to eq(1)
        end
      end
    end
  end
end
