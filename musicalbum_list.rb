require 'json'
require_relative 'music_album'

class MusicAlbumsList
  DATA_FILE = 'musicalbums_data.json'.freeze

  def initialize(my_ui)
    @musicalbums = load_musicalbums
  end

  def list_all_musicalbums
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    puts
  end

  def save_musicalbums
    File.write(DATA_FILE, JSON.pretty_generate(@musicalbums.map(&:to_hash)))
  end

  private

  def load_books
    return [] unless File.exist?(DATA_FILE)

    file_data = File.read(DATA_FILE)
    return [] if file_data.strip.empty?

    begin
      JSON.parse(file_data).map { |musicalbums_data| MusicAlbum.new(book_data['title'], book_data['author']) }
    rescue JSON::ParserError => e
      puts "Error parsing JSON file: #{e.message}"
      []
    end
  end
end
