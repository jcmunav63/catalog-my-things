# require_relative 'item'
require_relative 'music_album'

def main
  init_arrays
  puts 'Welcome to the Catalog of my Personal Things'
  loop do
    puts '1) List all books'
    puts '2) List all music albums'
    puts '3) List all movies'
    puts '4) List all games'
    puts '5) List all genres'
    puts '6) List all labels'
    puts '7) Create a Music Album'
    puts '8) Exit the app'
    print 'Enter your option here: '
    option = gets.chomp.to_i
    if option in (1..6)
      gets_option(option)
    else
      gets_option_b(option)
    end
  end
end

def gets_option(option)
  case option
  when 1
    list_all_books
  when 2
    list_all_music_albums
  when 3
    list_all_movies
  when 4
    list_all_games
  when 5
    list_all_genres
  when 6
    list_all_labels
  end
end

def gets_option_b(option)
  case option
  when 7
    create_music_album
  when 8
    puts 'Thank you for using this app!'
    exit
  else
    puts 'Invalid option'
  end
end

def init_arrays
  @musicalbums = []
end

# Placeholder for the list_all_books method
def list_all_books
  # Implement the list of all books...'
end

# Placeholder for the list all music albums method
def list_all_music_albums
  # implment list of all music albums...'
  puts
  MusicAlbum.all.each do |album|
    puts "#{album.id}. #{album.author} - #{album.genre} (#{album.publish_date})"
  end
end

# Placeholder for the list_all_movies method
def list_all_movies
  # puts 'Implement the list of all movies...'
end

# Placeholder for the list_all_gamees method
def list_all_games
  # puts 'Implement the list of all games...'
end

# Placeholder for the list all music albums method
def list_all_genres
  # implment list of all genres...'
  puts "\nList of all genres:"
  Genre.all.each do |genre|
    puts "#{genre.id}. #{genre.name}"
  end
end

# Placeholder for the list all labels method
def list_all_labels
  # implment list of all labels...'
end

# Placeholder for the list all labels method
# def create_music_album
#   MusicAlbum.create_music_album
# end
def create_music_album
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

main
