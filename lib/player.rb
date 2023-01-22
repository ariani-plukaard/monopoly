class Player
  attr_reader :name, :money, :position

  def initialize(attributes = {})
    @name = attributes[:name]
    @money = attributes[:money] || 16
    @position = attributes[:position] || 0
  end

  def update_money(number)
    @money += number
  end

  def update_position(roll, board_length)
    @position = (@position + roll) % board_length
  end

  def bankrupt?
    @money.negative?
  end
end
