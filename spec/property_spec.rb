require "property"

describe Property do
  let(:property) { Property.new(name: "Test", type: "property", colour: "Blue", price: 4) }

  context "initialized a property with property details" do
    it "property has the correct attributes: name, type, colour and price" do
      expect(property).to have_attributes(name: "Test", type: "property", colour: "Blue", price: 4)
    end
  end
  context "initialized a property with no owner" do
    it "returns nil for the owner" do
      expect(property.owner).to be_nil
    end
  end
end
