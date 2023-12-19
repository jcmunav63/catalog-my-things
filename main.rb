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
      break if option == 7

      handle_option(option)
    end
    puts 'Thank you for using this app!'
  end

  private

  def display_menu
    puts '1) Add new item'
    puts '2) Archive item'
    puts '3) List all items'
    puts '4) List all books'
    puts '5) List all labels'
    puts '6) Add a book'
    puts '7) Exit the app'
  end

  def gets_option
    print 'Enter your option here: '
    gets.chomp.to_i
  end

  def handle_option(option)
    case option
    when 1
      @catalog.create_item
    when 2
      @catalog.archive_item
    when 3
      @catalog.list_all_items
    when 4
      @catalog.list_all_books
    when 5
      @catalog.list_all_labels
    when 6
      @catalog.add_a_book
    else
      puts 'Invalid option'
    end
  end
end

Main.new.run
