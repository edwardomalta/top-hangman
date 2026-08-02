class Masker
  def initialize(word)
    @word = word
    @guessed_chars = ""
  end

  def do_mask
    word_masked = ""
    word_array = @word.split ""
    word_array.map do |char|
      word_masked += @guessed_chars.include?(char) ? " #{char}" : " _"
    end
    word_masked.strip
  end

  def add_guess(char)
    @guessed_chars += char
  end

  def is_word_unmasked?
    word_array = @word.split ""
    word_array.all? do |letter|
      @guesed_chars&.include?(letter)
    end
  end
end
