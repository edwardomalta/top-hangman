# How should be the basic game?
# 1. Choose one of the words from the dict.
# 2. Prompt it in (_ _ _ _ _) this fashion and ask the player to guess
#    here we can receive a char, or a string... may be we need to parse something
# 3. Check if the string/char ar in the word(posible it is an array).
# Then if fails, remove one of is chances (may be there is a max number of chances like 20 or something
# like that.
# If it was a char and if it was not in the array, then the same, it loses one guess chance.
# If he guessed correctly (strings recived -> array) == (array) theres is a winner.
# If the char is in the array the program must reveal it on the hidden word: guess("v") -> (_ _ v _ _)
# Then if the letter reveals the last hidden char the player wins and the game ends.

class Game
  def start
    greet
  end

  def greet(name: "player")
    puts "Wellcome to a new Hagman Game, #{name}"
  end
end
