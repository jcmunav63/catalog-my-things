require_relative 'music_album'
require_relative 'catalog'
require_relative 'genres_manager'
require 'time'

class AlbumManager
  def initialize
    @musicalbums = []
    @labels = []
    @genres = []
  end

  def list_all_music_albums
    puts
    puts '-- List of all Music Albums --'
    @musicalbums.each do |album|
      label_info = album.label.nil? ? 'N/A' : "#{album.label.title} #{album.label.color}"
      puts "(#{album.id}) | Genre: #{album.genre.name} | Author: #{album.author}" \
           " | Source: #{album.source} | Label: #{label_info}" \
           " | Publish date: #{album.publish_date.year} | On Spotify: #{album.on_spotify}"
    end
    puts
  end

  def add_a_music_album
    print 'Genre: '
    genre_name = gets.chomp
    print 'Author: '
    author = gets.chomp
    print 'Source: '
    source = gets.chomp
    print 'Label: '
    label_title = gets.chomp
    print 'Publish date (YYYY-MM-DD): '
    publish_date_str = gets.chomp
    print 'On Spotify (true / false): '
    on_spotify = gets.chomp.downcase == 'true'
    id1 = Random.rand(1..1000)
    id2 = Random.rand(1..1000)
    label = Label.new(id1, label_title, '')
    genre = Genre.new(id2, genre_name)
    album_data = {
      genre: genre, author: author, source: source, label: label, publish_date_str: publish_date_str, on_spotify: on_spotify
    }
    add_album_data(album_data)
  end

  def add_album_data(album_data)
    begin
      publish_date = Date.parse(album_data[:publish_date_str])
    rescue ArgumentError
      puts 'Invalid date format. Please use YYYY-MM-DD.'
      return
    end
    @musicalbums << MusicAlbum.new(
      genre: album_data[:genre],
      author: album_data[:author],
      source: album_data[:source],
      label: album_data[:label],
      publish_date: publish_date,
      on_spotify: album_data[:on_spotify]
    )
    @labels.push(album_data[:label]) unless @labels.include?(album_data[:label])
    @genres.push(album_data[:genre]) unless @genres.include?(album_data[:genre])
    puts 'Music Album created successfully!'
    puts '-- List of all Genres --'
    @genres.each do |genre|
      puts "(Id: #{genre.id}) | Genre: #{genre.name}"
    end
    puts
  end
end
