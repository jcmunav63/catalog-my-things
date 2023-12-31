require_relative 'music_album'
require_relative 'catalog'
require_relative 'label'
require_relative 'genre'
require_relative 'author'
require 'time'
require 'json'

class AlbumManager
  attr_accessor :musicalbums, :labels, :genres, :author

  def initialize
    @musicalbums = []
    @labels = []
    @genres = []
    @authors = []
  end

  def add_a_music_album
    genre_name = input_genre
    author_first_name = input_author_first
    author_last_name = input_author_last
    source = input_source
    label_title = input_label
    publish_date_str = input_publish_date
    on_spotify = input_on_spotify
    album_id = Random.rand(1..1000)
    id1 = Random.rand(1..1000)
    id2 = Random.rand(1..1000)
    author_id = generate_author_id
    label = Label.new(id1, label_title, '')
    genre = Genre.new(id2, genre_name)
    author = Author.new(author_id, author_first_name, author_last_name)
    publish_date = verify_date(publish_date_str)
    album = MusicAlbum.new(
      id: album_id,
      genre: genre,
      author: author,
      source: source,
      label: label,
      publish_date: publish_date,
      on_spotify: on_spotify
    )
    @musicalbums.push(album)
    @labels.push(label) unless @labels.include?(label)
    @genres.push(genre) unless @genres.include?(genre)
    @authors.push(author)
    store_label(label)
    store_genre(genre)
    store_musicalbum(album)
    store_author(author)
    display_message(' Music Album created successfully! ')
  end

  def generate_author_id
    stored_authors = load_data_from_file('data/authors.json')
    stored_authors.size
  end

  def list_all_music_albums
    puts
    puts '-- List of all Music Albums --'
    @musicalbums.each do |album|
      label_info = album.label.nil? ? 'N/A' : "#{album.label.title} #{album.label.color}"
      puts "(#{album.id}) | Genre: #{album.genre.name} | Author: #{album.author.last_name} #{album.author.first_name}" \
           "| Source: #{album.source} | Label: #{label_info}" \
           "| Publish date: #{album.publish_date.year || 'N/A'} | On Spotify: #{album.on_spotify}"
    end
    puts
  end

  def store_musicalbum(album)
    label_data = {
      id: album.id,
      genre: album.genre.name,
      authorlast: album.author.last_name,
      authorfirst: album.author.first_name,
      source: album.source,
      label: album.label.title,
      publish_date: album.publish_date,
      on_spotify: album.on_spotify
    }

    stored_musicalbums = load_data_from_file('data/musicalbums.json')
    stored_musicalbums << label_data
    write_data_to_file('data/musicalbums.json', stored_musicalbums)
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

  private

  def display_message(message)
    puts "╔#{'═' * (message.length + 2)}╗"
    puts "║ #{message.chomp} ║"
    puts "╚#{'═' * (message.length + 2)}╝"
  end

  def verify_date(publish_date)
    Date.parse(publish_date)
  rescue ArgumentError
    puts 'Invalid date format. Please use YYYY-MM-DD.'
    'N/A'
  end

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

  def input_on_spotify
    display_message(' On Spotify? (true / false): ')
    gets.chomp.downcase == 'true'
  end
end
