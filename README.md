# Monopoly
Monopoly game command-line app. In this game, the dice rolls predetermined and the app is used to purely to determine the results.
This project was completed as a solution for a coding test, prepared by Ariani Plukaard. The app was completed using test driven development (RSpec).

## About the Application

### Game Rules
* Four players take turns in the following order: Pooh, Piglet, Tigger and Eeyore.
* Each player starts on GO with $16.
* Each player gets $1 when they pass GO (excluding starting move). 'Pass GO' includes passing or landing on GO (not moving off GO onto to another space, as this would double-up).
* If a player lands on an unowned property, they have to buy the property.
* If a player lands on an owned property, they have to pay rent (equal to property value) to the property owner.
* Rent is doubled if the same owner owns all property of the same colour.
* Once one of the players becomes bankrupt, the player with the most money remaining is the winner. If all rolls have been made but still no-one is bankrupt, the winner is still the player with the most money remaining.
* The board is made up only of properties and one GO.
* The board wraps around (the last space is followed by the first space).

### Game/App Logic Assumptions
* It is assumed that the board and rolls JSON files are in the correct format.
* It is assumed that the board source (board.json) and players remain the same, and only the rolls change between each game. Therefore, only the rolls file is handed in as a command-line argument.
* The size of a roll will be less than the number of spaces on the board, i.e. a player can not loop around to the same position (or past it) and cannot pass GO more than once in a turn.

### Task of the App
* Read the board spaces from the board.json file
* Read the predetermined dice rolls from the dice rolls JSON files and simulate the game as per the rules
* Output the following:
  * Winner of each game
  * Amount of money each player has at the end of the game
  * Which board space each player is on when the game ends

## Using the Application

### App Installation Instructions
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
