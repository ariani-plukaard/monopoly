require_relative 'board_space'

class Property < BoardSpace
  attr_reader :colour, :price, :owner

  def initialize(attributes = {})
    super(name: attributes[:name])
    @colour = attributes[:colour]
    @price = attributes[:price]
    @owner = attributes[:owner]
  end

  def add_owner(owner)
    @owner = owner
  end
end
