require 'json'
require 'go'
require 'property'

class Board
  attr_reader :board_spaces, :players

  def initialize(board_string, players_array)
    @board_spaces = load_spaces(board_string)
    @players = load_players(players_array)
    @active_player_index = 0
  end

  def make_turn(roll)
    previous_position = @players[@active_player_index].position
    new_position = @players[@active_player_index].update_position(roll, @board_spaces.length)
    @players[@active_player_index].update_money(1) if passed_go?(previous_position, new_position)
    property_action(new_position)
  end

  private

  def passed_go?(previous_position, new_position)
    new_position < previous_position
  end

  def property_action(position)
    on_go = @board_spaces[position].instance_of?(Go)
    players_own_property = !on_go && @board_spaces[position].owner == @players[@active_player_index]
    if !on_go && !@board_spaces[position].owner
      buy_property(position)
    elsif !on_go && !players_own_property
      pay_rent(position)
    end
  end

  def pay_rent(position)
    colour = @board_spaces[position].colour
    colour_group = @board_spaces.select { |space| space.instance_of?(Property) && space.colour == colour }
    owners = colour_group.map(&:owner)
    rent_size = owners.uniq.length == 1 ? 2 : 1
    @players[@active_player_index].update_money(-(rent_size * @board_spaces[position].price))
  end

  def buy_property(position)
    @board_spaces[position].add_owner(@players[@active_player_index])
    @players[@active_player_index].update_money(-@board_spaces[position].price)
  end

  def load_players(players_array)
    players_array.map { |player| Player.new(player) }
  end

  def load_spaces(board_string)
    board_spaces = JSON.parse(board_string, symbolize_names: true)
    board_spaces.map do |board_space|
      board_space[:type] == 'go' ? Go.new(board_space) : Property.new(board_space)
    end
  end
end
