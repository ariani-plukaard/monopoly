class Player
  def initialize(name)
    @name = name
    @money = 16
  end

  def update_money(number)
    @money += number
  end
end
