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
require "yaml"
require_relative "masker"
require_relative "filemanager"

class Game
  MAX_CHANCES = 10 
  def initialize(data: {})
    @chances_remaining = data[:chances_remaining] || MAX_CHANCES
    @file_manager = FileManager.new
    @failed_attempts = []
    unless data.empty?
      set_word(data[:word], g_chars: data[:guessed_chars])
      @loaded_game = true
      @game_file = data[:game_file]
    end
  end

  def start
    greet unless @loaded_game
    loop_guess
    if @masker.is_word_unmasked?
      puts "Congratulations!"
      puts "You win!"
      reveal_word
      File.delete(@game_file) if @loaded_game
    elsif @chances_remaining > 0
      puts "Come back soon!"
    else
      puts "You run out of chances"
      puts "You lose!"
      puts "Good luck for the next try."
      reveal_word
    end
  end

  def reveal_word
    puts "The word was: #{@word}"
  end

  def greet(name: "player")
    puts "Wellcome to a new Hagman Game, #{name}"
    puts "The computer will select a word from an English dict."
    puts "the purpose is you have to guess what the word is."
    puts "for doing so you can write: a character or a word" 
    puts "(if you think you know what word is it)"
    puts "You have #{MAX_CHANCES} chances to guess it. Good Luck!"
  end

  def set_word(word, g_chars: "")
    @word = word.downcase
    @masker = Masker.new(@word, g_chars: g_chars)
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
      save
    end
  end
  
  def save
    game_status = {
      :word => @word, 
      :guessed_chars => @masker.guessed_chars, 
      :chances_remaining => @chances_remaining
    }
    file_name = `date +%Y-%m-%d-%H-%M-%s`.strip 

    Dir.chdir(@file_manager.get_game_dir)
    File.open(file_name, "w+") do |file|
      file.write(YAML.dump(game_status))
    end
    Dir.chdir(@file_manager.get_basic_dir)
  end

  def self.load(game)
    game_file = FileManager.new.get_game_dir + game
    data = YAML.load(File.read(game_file))
    data[:game_file] = game_file
    self.new(data: data)
  end

  def loop_guess
    until @chances_remaining < 1 or @masker.is_word_unmasked? do  
      puts "Last failed attempts: #{@failed_attempts.join(", ")}"
      print "( #{@masker.do_mask} ) chances remaining #{@chances_remaining} > "
      answer = gets.strip
      if is_input_a_command?(answer)
        if answer.split("")[1] == "s"
          do_execute_command("s")
          break
        else
          puts "Unknown command. Ignoring..."
          next
        end
      end
      if answer.split("").length == 1
        @masker.add_guess(answer.downcase)
      elsif answer.split("").length > 1 && answer.downcase == @word.downcase
        @masker.add_guess(answer.downcase)
      else
        puts "ups, that did not work"
      end

      @chances_remaining -= 1
    end
  end
end
