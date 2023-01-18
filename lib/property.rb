class Property
  attr_reader :name, :type, :colour, :price, :owner

  def initialize(attributes = {})
    @name = attributes[:name]
    @type = attributes[:type]
    @colour = attributes[:colour]
    @price = attributes[:price]
    @owner = attributes[:owner]
  end

  def add_owner(owner)
    @owner = owner
  end
end
