require_relative "lib/game"

# The responsibility from the welcom belongs to here. Then I can 
# create a new game, open an saved game.

game = Game.new

game.set_word("eyes")
game.start
