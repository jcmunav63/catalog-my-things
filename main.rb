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
      break if option == 4

      handle_option(option)
    end
    puts 'Thank you for using this app!'
  end

  private

  def display_menu
    puts '1) List all books'
    puts '2) List all labels'
    puts '3) Add a book'
    puts '4) Exit the app'
  end

  def gets_option
    print 'Enter your option here: '
    gets.chomp.to_i
  end

  def handle_option(option)
    case option
    when 1
      @catalog.list_all_books
    when 2
      @catalog.list_all_labels
    when 3
      @catalog.add_a_book
    else
      puts 'Invalid option'
    end
  end
end

Main.new.run
