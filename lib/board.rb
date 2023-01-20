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
    turn_property_action(new_position)
  end

  private

  def passed_go?(previous_position, new_position)
    new_position < previous_position
  end

  def turn_property_action(position)
    on_go = @board_spaces[position].instance_of?(Go)
    if !on_go && !@board_spaces[position].owner
      @board_spaces[position].add_owner(@players[@active_player_index])
      @players[@active_player_index].update_money(-@board_spaces[position].price)
    end
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
