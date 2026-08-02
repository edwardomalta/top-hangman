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
require_relative "masker"

class Game
  MAX_CHANCES = 10 
  def initialize
    @chances_remaining = MAX_CHANCES
  end

  def start
    greet
    loop_guess
    if @masker.is_word_unmasked?
      puts "Congratulations!"
      puts "You win!"
    elsif @chances_remaining > 0
      puts "Come back soon!"
    else
      puts "You run out of chances"
      puts "You lose!"
      puts "Good luck for the next try."
    end
  end

  def greet(name: "player")
    puts "Wellcome to a new Hagman Game, #{name}"
    puts "The computer will select a word from an English dict."
    puts "the purpose is you have to guess what the word is."
    puts "for doing so you can write: a character or a word" 
    puts "(if you think you know what word is it)"
    puts "You have #{MAX_CHANCES} chances to guess it. Good Luck!"
  end

  def set_word(word)
    @word = word
    @masker = Masker.new(@word)
  end

  def is_input_a_command?(input)
    input_array = input.split ""
    if input_array[0] == "/"
      puts "Player entered a command..."
      return true
    end
    false
  end

  def do_execute_command(char)
    # For now only save will work
    if char == "s"
      puts "Saving... "
    end
  end

  def loop_guess
    until @chances_remaining < 1 or @masker.is_word_unmasked? do  
      print "( #{@masker.do_mask} ) chances remaining #{@chances_remaining} > "
      answer = gets
      if is_input_a_command?(answer)
        if answer.split("")[1] == "s"
          do_execute_command("s")
          break
        else
          puts "Unknown command. Ignoring..."
          next
        end
      end
      @masker.add_guess(answer)
      @chances_remaining -= 1
    end
  end
end
