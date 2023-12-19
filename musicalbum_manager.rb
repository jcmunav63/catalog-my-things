require_relative 'music_album'

class AlbumManager

  
  def initialize
  end

  def add_a_music_album
    print 'Genre: '
    genre = gets.chomp
    print 'Author: '
    author = gets.chomp
    print 'Source: '
    source = gets.chomp
    print 'Label: '
    label = gets.chomp
    print 'Publish date: '
    publish_date = gets.chomp
    print 'On Spotify (true / false): '
    on_spotify = gets.chomp
    @musicalbums << MusicAlbum.new(genre, author, source, label, publish_date, on_spotify)
    puts 'Music Album created successfully!'
    puts
  end
end
