require 'json'
require_relative 'go'
require_relative 'property'
require_relative 'player'

class Board
  attr_reader :board_spaces, :players, :active_player

  def initialize(board_string, players_array)
    @board_spaces = load_spaces(board_string)
    @players = load_players(players_array)
    @active_player = @players[0]
    @active_space = @board_spaces[@active_player.position]
  end

  def make_turn(roll)
    previous_position = @active_player.position
    new_position = @active_player.update_position(roll, @board_spaces.length)
    @active_space = @board_spaces[new_position]
    @active_player.update_money(1) if passed_go?(previous_position, new_position)
    property_action
  end

  def next_player
    previous_player_index = @players.index(@active_player)
    active_player_index = previous_player_index == @players.length - 1 ? 0 : previous_player_index + 1
    @active_player = @players[active_player_index]
  end

  def results
    results = @players.sort_by(&:money).reverse
    results.map do |player|
      {
        player: player.name,
        money: player.money,
        final_position: @board_spaces[player.position].name
      }
    end
  end

  private

  def passed_go?(previous_position, new_position)
    new_position < previous_position
  end

  def property_action
    not_on_go = !@active_space.instance_of?(Go)
    property_not_owned = not_on_go && @active_space.owner.nil?
    active_player_not_owner = not_on_go && @active_space.owner != @active_player
    if not_on_go && property_not_owned
      buy_property
    elsif not_on_go && active_player_not_owner
      pay_rent
    end
  end

  def pay_rent
    colour_group = @board_spaces.select { |space| space.instance_of?(Property) && space.colour == @active_space.colour }
    owners = colour_group.map(&:owner)
    rent_size = owners.uniq.length == 1 ? 2 * @active_space.price : @active_space.price
    @active_player.update_money(-rent_size)
    @active_space.owner.update_money(rent_size)
  end

  def buy_property
    @active_space.add_owner(@active_player)
    @active_player.update_money(-@active_space.price)
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
