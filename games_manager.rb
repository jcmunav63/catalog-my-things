require_relative 'game'
require_relative 'label'
require_relative 'genre'
require_relative 'catalog'
require_relative 'author'
require 'json'
require 'date'
require 'fileutils'

class GamesManager
  attr_accessor :games, :labels, :genres, :author

  def initialize
    @games = []
    @labels = []
    @genres = []
    @authors = []
  end

  def add_a_game
    genre_name = input_genre
    author_first_name = input_author_first
    author_last_name = input_author_last
    source = input_source
    label_title = input_label
    publish_date_str = input_publish_date
    multiplayer = input_multiplayer
    last_played = input_last_played_at
    publish_date = verify_date(publish_date_str)
    last_played_at = verify_date(last_played)
    label_id = generate_label_id
    genre_id = generate_genre_id
    author_id = generate_author_id
    game_id = generate_game_id
    label = Label.new(label_id, label_title, '')
    genre = Genre.new(genre_id, genre_name)
    author = Author.new(author_id, author_first_name, author_last_name)
    game = Game.new(id: game_id, genre: genre, author: author, source: source,
                    label: label, publish_date: publish_date, multiplayer: multiplayer,
                    last_played_at: last_played_at)
    @games.push(game)
    @labels.push(label)
    @genres.push(genre)
    @authors.push(author)
    display_message(' The Game was added successfully! ')
    store_game(game)
    store_label(label)
    store_genre(genre)
    store_author(author)
  end

  def generate_game_id
    stored_games = load_data_from_file('data/games.json')
    stored_games.size
  end

  def generate_label_id
    stored_labels = load_data_from_file('data/labels.json')
    stored_labels.size
  end

  def generate_genre_id
    stored_genres = load_data_from_file('data/genres.json')
    stored_genres.size
  end

  def generate_author_id
    stored_authors = load_data_from_file('data/authors.json')
    stored_authors.size
  end

  def store_game(game)
    game_data = {
      id: game.id,
      genre: game.genre.name,
      authorlast: game.author.last_name,
      authorfirst: game.author.first_name,
      source: game.source,
      label: game.label.title,
      publish_date: game.publish_date,
      multiplayer: game.multiplayer,
      last_played_at: game.last_played_at,
      archived: game.archived
    }

    stored_games = load_data_from_file('data/games.json')
    stored_games << game_data
    write_data_to_file('data/games.json', stored_games)
  end

  def store_label(label)
    label_data = {
      id: label.id,
      title: label.title,
      color: label.color,
      item_ids: label.items.map(&:id)
    }

    stored_labels = load_data_from_file('data/labels.json')
    stored_labels << label_data
    write_data_to_file('data/labels.json', stored_labels)
  end

  def store_genre(genre)
    genre_data = {
      id: genre.id,
      name: genre.name,
      item_ids: genre.items.map(&:id)
    }

    stored_genres = load_data_from_file('data/genres.json')
    stored_genres << genre_data
    write_data_to_file('data/genres.json', stored_genres)
  end

  def store_author(author)
    author_data = {
      id: author.id,
      first_name: author.first_name,
      last_name: author.last_name,
      item_ids: author.items.map(&:id)
    }

    stored_authors = load_data_from_file('data/authors.json')
    stored_authors << author_data
    write_data_to_file('data/authors.json', stored_authors)
  end

  def load_data_from_file(file_path)
    return [] unless File.exist?(file_path)

    data = File.read(file_path)
    data.empty? ? [] : JSON.parse(data)
  rescue Errno::ENOENT
    []
  end

  def write_data_to_file(file_path, data)
    FileUtils.mkdir_p('data')
    File.write(file_path, data.to_json)
  end

  def list_all_games
    puts
    puts '-- List of all Games --'
    @games = load_data_from_file('data/games.json')
    @games.each do |game|
      puts "(#{game['id']}) | Genre: #{game['genre']} | Author: #{game['authorlast']} #{game['authorfirst']}" \
           "| Source: #{game['source']} | Label: #{game['label']}" \
           "| Publish date: #{game['publish_date']} | Multiplayer: #{game['multiplayer']}" \
           "| Last played at: #{game['last_played_at']}"
    end
  end

  def verify_date(publish_date)
    Date.parse(publish_date)
  rescue ArgumentError
    puts 'Invalid date format. Please use YYYY-MM-DD.'
    'N/A'
  end

  private

  def input_genre
    display_message(' Genre: ')
    gets.chomp
  end

  def input_author_first
    display_message(' Author\'s first name: ')
    gets.chomp
  end

  def input_author_last
    display_message(' Author\'s last name: ')
    gets.chomp
  end

  def input_source
    display_message(' Source: ')
    gets.chomp
  end

  def input_label
    display_message(' Label: ')
    gets.chomp
  end

  def input_publish_date
    display_message(' Publish date: ')
    gets.chomp
  end

  def input_multiplayer
    display_message(' Multiplayer? (Yes / No): ')
    gets.chomp.downcase
  end

  def input_last_played_at
    display_message(' Last played at (YYYY-MM-DD): ')
    gets.chomp
  end

  def display_message(message)
    puts "╔#{'═' * (message.length + 2)}╗"
    puts "║ #{message.chomp} ║"
    puts "╚#{'═' * (message.length + 2)}╝"
  end
end
