require 'property'
require 'player'

describe Property do
  let(:property) { Property.new(name: 'Test', colour: 'Blue', price: 4) }

  context 'instance initialized with property details' do
    it 'has the correct attributes: name, type, colour and price' do
      expect(property).to have_attributes(name: 'Test', colour: 'Blue', price: 4)
    end
  end
  context 'instance initialized with no owner' do
    it 'returns nil for the owner' do
      expect(property.owner).to be_nil
    end
  end

  describe '#add_owner' do
    context 'given a player' do
      let(:owner) { Player.new }
      it 'returns player as the owner of the property' do
        expect(property.add_owner(owner)).to eq(owner)
      end
    end
  end
end
