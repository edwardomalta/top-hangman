class FileManager
  def get_basic_dir
    basic_dir = `pwd`
    basic_dir.strip
  end
  
  def get_game_dir
    game_directory = get_basic_dir + "/games/"
    Dir.mkdir(game_directory) unless Dir.exist?(game_directory)
    game_directory
  end
end
