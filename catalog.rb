require_relative 'book_manager'
require_relative 'musicalbum_manager'
require_relative 'attributes_lists'
require_relative 'games_manager'

class Catalog
  def initialize
    @book_manager = BookManager.new
    @musicalbum_manager = AlbumManager.new
    @attributes_lists = AttributesLists.new
    @games_manager = GamesManager.new
  end

  def list_all_books
    @book_manager.list_all_books
  end

  def list_all_music_albums
    @musicalbum_manager.list_all_music_albums
  end

  def list_all_movies
    @movies_manager.list_all_movies
  end

  def list_all_games
    @games_manager.list_all_games
  end

  def list_all_genres
    @attributes_lists.list_all_genres
  end

  def list_all_labels
    @attributes_lists.list_all_labels
  end

  def list_all_authors
    @attributes_lists.list_all_authors
  end

  def list_all_sources
    @sources_manager.list_all_sources
  end

  def add_a_book
    @book_manager.add_a_book
  end

  def add_a_music_album
    @musicalbum_manager.add_a_music_album
  end

  def add_a_movie
    @movies_manager.add_a_movie
  end

  def add_a_game
    @games_manager.add_a_game
  end
end
