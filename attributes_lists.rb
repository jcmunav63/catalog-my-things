require_relative 'label'
require_relative 'genre'
require_relative 'book_manager'
require_relative 'musicalbum_manager'
require_relative 'catalog'
require 'json'
require 'fileutils'

class AttributesLists
  def initialize
    @loaded_labels = []
  end

  def load_data_from_file(file_path)
    return [] unless File.exist?(file_path)

    data = File.read(file_path)
    data.empty? ? [] : JSON.parse(data)
  rescue Errno::ENOENT
    []
  end

  def list_all_labels
    @loaded_labels = load_data_from_file('data/labels.json')
    @loaded_labels.each do |label|
      display_message("Label: #{label['title']}, Color: #{label['color']}")
    end
  end

  def display_message(message)
    puts "╔#{'═' * (message.length + 2)}╗"
    puts "║ #{message.chomp} ║"
    puts "╚#{'═' * (message.length + 2)}╝"
  end
end
