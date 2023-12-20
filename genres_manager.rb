require_relative 'genre'
require_relative 'musicalbum_manager'

class GenresManager
  def list_all_genres
    puts
    puts '-- List of all Genres --'
    @genres.each do |genre|
      puts "(Id: #{genre.id}) | Genre: #{genre.name}"
    end
    puts
  end
end
