## Woven Monopoly
Command-line app for Woven coding test - Prepared by Ariani Plukaard

### Installation Instructions
* This program was developed using Ruby version 3.1.2.
* Run a `bundle install` to install the gems

### Usage Instructions
To run the code, run the game.rb file with a rolls JSON file as command-line argument, e.g.:

* ```ruby lib/game.rb rolls_1.json```

* ```ruby lib/game.rb rolls_2.json```

This will output the outcome based on the rolls loaded.

### Troubleshooting
* To test the code, run the rspec in command-line with:
    `bundle exec rspec`
* The file will not run if a JSON file containing the rolls is not included as a command-line argument when running game.rb

### Design Decisions/Assumptions
* Rent rate is the same as the value of the property owned
* 'Pass Go' includes passing or landing on Go (not moving off Go onto to another space, as this would double-up)
* The size of a roll will be less than the number of spaces on the board, i.e. a player can not loop around to the same position (or past it) and cannot pass Go more than once in a turn
* It is assumed that the board and rolls JSON files are in the correct format
* If all rolls have been made but still no-one is bankrupt, the winner is still the player with the most money remaining
* It is assumed that the board source (board.json) and players remain the same and only the rolls change between each game
