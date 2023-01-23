require 'json'

# require 'player'
# require 'board'
# require 'board_space'
# require 'property'
# require 'go'

roll_file = ARGV[0]

def read_rolls(roll_file)
  # serialized_rolls = File.read(rolls_file)
  # rolls = JSON.parse(serialized_rolls)
end

def simulate_game
end

def run_game(roll_file)
  if roll_file&.end_with?('.json')
    read_rolls(roll_file)
    simulate_game
    true
  else
    puts '--- Run the game with a rolls json file command-line argument. ---'
    false
  end
end

puts run_game(roll_file)

# board_spaces_file = 'board.json'
# serialized_board_spaces = File.read(board_spaces_file)
