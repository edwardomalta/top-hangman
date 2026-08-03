require_relative "lib/game"
require_relative "lib/gamedector"

# The responsibility from the welcom belongs to here. Then I can 
# create a new game, open an saved game.

games_saved = GameDetector.new.detect_games
if games_saved.length > 0
  puts "There are some saved games. Do you want to open one?"
  answer = gets
  if answer[0] == "y"
    i = 1
    games_saved.map do |item|
      puts "#{i} - #{item}"
      i += 1
    end
    print "Write the number you want to open: "
    number_of_game = gets.to_i
    game = Game.load(games_saved[number_of_game - 1])
    game.start
    return
  end
end 
game = Game.new

game.set_word("eyes")
game.start
