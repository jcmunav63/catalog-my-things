require_relative 'book'
require_relative 'label'
require 'json'
require 'date'
require 'fileutils'

class BookManager
  attr_accessor :books, :labels

  def initialize
    @books = []
    @labels = []
  end

  def add_a_book
    color = input_book_color
    publish_date = input_publish_date
    publisher = input_publisher
    author = input_author
    label_title = input_label_title
    cover_condition = input_cover_condition
    label_id = generate_label_id
    label = Label.new(label_id, label_title, color)
    book_id = generate_book_id
    book = Book.new(id: book_id, publish_date: publish_date, author: author, label: label, publisher: publisher,
                    cover_state: cover_condition, genre: nil, source: nil)
    @books.push(book)
    @labels.push(label)
    display_message('Book added successfully.')
    store_book(book)
    store_label(label)
  end

  def generate_book_id
    stored_books = load_data_from_file('data/books.json')
    stored_books.size
  end

  def generate_label_id
    stored_labels = load_data_from_file('data/labels.json')
    stored_labels.size
  end

  def input_cover_condition
    loop do
      display_message('Enter the book cover condition (GOOD or BAD): ')
      cover_condition = gets.chomp.upcase
      return cover_condition if %w[GOOD BAD].include?(cover_condition)

      display_message('Invalid cover condition. Please enter either GOOD or BAD.')
    end
  end

  def store_book(book)
    book_data = {
      id: book.id,
      publisher: book.publisher,
      publish_date: book.publish_date,
      cover_condition: book.cover_state,
      genre: book.genre,
      author: book.author,
      source: book.source,
      label: book.label.title,
      archived: book.archived
    }

    stored_books = load_data_from_file('data/books.json')
    stored_books << book_data
    write_data_to_file('data/books.json', stored_books)
  end

  def store_label(label)
    label_data = {
      id: label.id,
      title: label.title,
      color: label.color
    }

    stored_labels = load_data_from_file('data/labels.json')
    stored_labels << label_data
    write_data_to_file('data/labels.json', stored_labels)
  end

  def load_data_from_file(file_path)
    return [] unless File.exist?(file_path)

    data = File.read(file_path)
    data.empty? ? [] : JSON.parse(data)
  rescue Errno::ENOENT
    []
  end

  def write_data_to_file(file_path, data)
    FileUtils.mkdir_p('data')
    File.write(file_path, data.to_json)
  end

  def list_all_books
    @books = load_data_from_file('data/books.json')
    @books.each do |book|
      display_message("Book id: #{book['id']}, Publisher: #{book['publisher']},
        Publish Date: #{book['publish_date']}, Cover Condition: #{book['cover_condition']}")
    end
  end

  def list_all_labels
    @labels = load_data_from_file('data/labels.json')
    @labels.each do |label|
      display_message("Label: #{label['title']}, Color: #{label['color']}")
    end
  end

  private

  def input_book_color
    display_message('Enter the book cover color: ')
    gets.chomp
  end

  def input_publish_date
    display_message('Enter the book\'s publish date (YYYY-MM-DD): ')
    gets.chomp
  end

  def input_publisher
    display_message('Enter the book publisher: ')
    gets.chomp
  end

  def input_author
    display_message('Enter the book author: ')
    gets.chomp
  end

  def input_label_title
    display_message('Enter the book label: ')
    gets.chomp
  end

  def display_message(message)
    puts "╔#{'═' * (message.length + 2)}╗"
    puts "║ #{message.chomp} ║"
    puts "╚#{'═' * (message.length + 2)}╝"
  end
end
