require_relative "filemanager"
class GameDetector
  def initialize
    @file_manager = FileManager.new
  end

  def detect_games
    list_of_games = `ls #{@file_manager.get_game_dir}`.split
  end
end
