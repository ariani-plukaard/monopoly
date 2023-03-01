require 'json'

require_relative 'board'

def read_rolls(rolls_file)
  serialized_rolls = File.read(rolls_file)
  JSON.parse(serialized_rolls)
end

def print_results(board)
  puts '---------------------------------------------------------'
  board.results.each_with_index do |result, index|
    print 'WINNER: ' if index.zero?
    puts "#{result[:player]} has $#{result[:money]} and finished the game on #{result[:final_position]}"
  end
  puts '---------------------------------------------------------'
end

def simulate_game(rolls, board_string, players)
  board = Board.new(board_string, players)
  rolls.each do |roll|
    board.make_turn(roll)
    break if board.active_player.bankrupt?

    board.next_player
  end
  print_results(board)
end

def run_game(rolls_file, players)
  if rolls_file&.end_with?('.json')
    rolls = read_rolls(rolls_file)
    board = File.read('board.json')
    simulate_game(rolls, board, players)
    true
  else
    puts '--- Run the game with a rolls json file command-line argument. ---'
    false
  end
end

rolls_file = ARGV[0]
players = [{ name: 'Pooh' }, { name: 'Piglet' }, { name: 'Tigger' }, { name: 'Eeyore' }]

run_game(rolls_file, players)
