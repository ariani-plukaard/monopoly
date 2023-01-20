require 'json'
require 'go'
require 'property'

class Board
  attr_reader :board_spaces, :players

  def initialize(board_string, players_array)
    @board_spaces = load_spaces(board_string)
    @players = load_players(players_array)
  end

  def move_player(player_index, roll)
    previous_position = @players[player_index].position
    new_position = @players[player_index].update_position(roll, @board_spaces.length)
    @players[player_index].update_money(1) if passed_go?(previous_position, new_position)
  end

  private

  def passed_go?(previous_position, new_position)
    new_position < previous_position
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
