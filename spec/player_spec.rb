require "player"

describe Player do
  let(:player) { Player.new("Test Name") }
  describe "#update_money" do
    context "given integer 1" do
      it "returns the player's money with 1 added" do
        expect(player.update_money(1)).to eq(17)
      end
    end
    context "given integer -2" do
      it "returns the player's money with 2 subtracted" do
        expect(player.update_money(-2)).to eq(14)
      end
    end
  end
end
