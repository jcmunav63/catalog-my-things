require_relative 'book'
require_relative 'label'

class BookManager
  attr_accessor :books, :labels

  def initialize
    @book = []
    @labels = []
  end

  def add_book # rubocop:disable Metrics/MethodLength
    display_message('Enter the book title: ')
    title = gets.chomp
    display_message('Enter the book cover color: ')
    color = gets.chomp
    display_message('Enter the book\'s publish date (YYYY-MM-DD): ')
    publish_date = gets.chomp
    display_message('Enter the book publisher: ')
    publisher = gets.chomp
    display_message('Enter the book author: ')
    author = gets.chomp
    display_message('Enter the book label: ')
    label_title = gets.chomp
    cover_condition = input_cover_condition

    book_id = generate_book_id
    book = Book.new(id: book_id, publisher: publisher, cover_state: cover_condition, title: title, publish_date: publish_date, author: author, label: label_title)

    label_id = generate_label_id
    label = Label.new(id: label_id, title: label_title, color: color)

    @books.push(book)
    @labels.push(label)
    display_message('Book added successfully.')
    store_book(book)
    store_label(label)
  end

  private

  def display_message(message)
    puts "╔#{'═' * (message.length + 2)}╗"
    puts "║ #{message.chomp} ║"
    puts "╚#{'═' * (message.length + 2)}╝"
  end
end