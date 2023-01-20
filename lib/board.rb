require 'json'
require 'go'
require 'property'

class Board
  attr_reader :board_spaces, :players

  def initialize(board_string, players_array)
    @board_spaces = load_spaces(board_string)
    @players = load_players(players_array)
  end

  private

  def load_players(players_array)
    players_array.map { |player| Player.new(name: player) }
  end

  def load_spaces(board_string)
    board_spaces = JSON.parse(board_string, symbolize_names: true)
    board_spaces.map do |board_space|
      board_space[:type] == 'go' ? Go.new(board_space) : Property.new(board_space)
    end
  end
end
