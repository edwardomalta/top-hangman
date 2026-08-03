require_relative "filemanager.rb"

class WordPicker
  def initialize
    get_list_of_words
  end

  def get_list_of_words
    @list_of_words = []
    file_dict = FileManager.new.get_basic_dir + "/dict.txt"
    File.open(file_dict) do |dictionary|
      until dictionary.eof?
        line = dictionary.readline.strip
        next if line.length < 5 || line.length > 12
        @list_of_words << line.strip
      end
    end
  end

  def pick_word
    @list_of_words.sample
  end
end
