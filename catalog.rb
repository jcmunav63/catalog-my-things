require_relative 'book_manager'

class Catalog
  def initialize
    @book_manager = Bookmanager.new
    @items = []
    @labels = []
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
    @genres.list_all_genres
  end

  def list_all_labels
    @labels_manager.list_all_labels
  end

  def list_all_authors
    @authors_manager.list_all_authors
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
