require 'player'

describe Player do
  let(:player) { Player.new }

  context 'instance initialized using the name Test Player and default money and position' do
    let(:player) { Player.new(name: 'Test Player') }
    it 'has the correct starting attributes: name, money (16) and position (0)' do
      expect(player).to have_attributes(name: 'Test Player', money: 16, position: 0)
    end
  end

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

  describe '#bankrupt?' do
    context "player's money is positive" do
      it 'returns false - not bankrupt' do
        expect(player.bankrupt?).to eq(false)
      end
    end
    context "player's money is 0" do
      let(:player) { Player.new(money: 0) }
      it 'returns false - not bankrupt' do
        expect(player.bankrupt?).to eq(false)
      end
    end
    context "player's money is negative" do
      let(:player) { Player.new(money: -1) }
      it 'returns true - is bankrupt' do
        expect(player.bankrupt?).to eq(true)
      end
    end
  end
end
