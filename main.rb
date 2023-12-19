require_relative 'item'
require_relative 'book'
require_relative 'label'
require_relative 'catalog'

class Main
  def initialize
    @catalog = Catalog.new
  end

  def run
    puts 'Welcome to the Catalog of my Personal Things'
    loop do
      display_menu
      option = gets_option
      break if option == 13

      handle_option(option)
    end
    puts 'Thank you for using this app!'
  end

  private

  def display_menu
    puts '1) List all books'
    puts '2) List all labels'
    puts '3) Add a book'
    puts '4) Exit the app'
  end

  def gets_option
    print 'Enter your option here: '
    gets.chomp.to_i
  end

  def handle_option(option)
    method_name = option_methods[option]
    if method_name
      send(method_name)
    else
      puts 'Invalid option'
    end
  end

  def option_methods
    {
      1 => :list_all_books,
      2 => :list_all_music_albums,
      3 => :list_all_movies,
      4 => :list_all_games,
      5 => :list_all_genres,
      6 => :list_all_labels,
      7 => :list_all_authors,
      8 => :list_all_sources,
      9 => :add_a_book,
      10 => :add_a_music_album,
      11 => :add_a_movie,
      12 => :add_a_game
    }
  end

  def list_all_books
    @catalog.list_all_books
  end

  def list_all_music_albums
    @catalog.list_all_music_albums
  end

  def list_all_movies
    @catalog.list_all_movies
  end

  def list_all_games
    @catalog.list_all_games
  end

  def list_all_genres
    @catalog.list_all_genres
  end

  def list_all_labels
    @catalog.list_all_labels
  end

  def list_all_authors
    @catalog.list_all_authors
  end

  def list_all_sources
    @catalog.list_all_sources
  end

  def add_a_book
    @catalog.add_a_book
  end

  def add_a_music_album
    @catalog.add_a_music_album
  end

  def add_a_movie
    @catalog.add_a_movie
  end

  def add_a_game
    @catalog.add_a_game
  end
end

Main.new.run
