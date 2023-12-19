class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(args = {})
    super(args[:genre], args[:author], args[:source], args[:label], args[:publish_date])
    @on_spotify = args[:on_spotify]
  end

  def can_be_archived?
    super && @on_spotify
  end

  # def create_musicalbum
  #   print 'Genre: '
  #   genre = gets.chomp
  #   print 'Author: '
  #   author = gets.chomp
  #   print 'Source: '
  #   source = gets.chomp
  #   print 'Label: '
  #   label = gets.chomp
  #   print 'Publish date: '
  #   publish_date = gets.chomp
  #   print 'On Spotify (true / false): '
  #   on_spotify = gets.chomp
  #   @musicalbums << MusicAlbum.new(genre, author, source, label, publish_date, on_spotify)
  #   puts 'Music Album created successfully!'
  #   puts
  # end
end
