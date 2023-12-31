require_relative 'book'
require_relative 'label'
require_relative 'author'
require_relative 'genre'
require 'json'
require 'date'
require 'fileutils'

class BookManager
  attr_accessor :books, :labels, :authors, :genres

  def initialize
    @books = []
    @labels = []
    @authors = []
    @genres = []
  end

  def add_a_book
    color = input_book_color
    publish_date = input_publish_date
    publisher = input_publisher
    author_first_name, author_last_name = input_author_name
    label_title = input_label_title
    cover_condition = input_cover_condition
    label_id = generate_label_id
    author_id = generate_author_id
    genre_name = input_genre_name
    genre_id = input_genre_id
    genre = Genre.new(genre_id, genre_name)
    label = Label.new(label_id, label_title, color)
    book_id = generate_book_id
    author = Author.new(author_id, author_first_name, author_last_name)
    book = Book.new(id: book_id, publish_date: publish_date, author: author, label: label, publisher: publisher,
                    cover_state: cover_condition, genre: genre, source: nil)

    @books.push(book)
    @labels.push(label)
    @authors.push(author)
    @genres.push(genre)
    display_message('Book added successfully.')
    store_book(book)
    store_label(label)
    store_author(author)
    store_genre(genre)
  end

  def generate_book_id
    stored_books = load_data_from_file('data/books.json')
    stored_books.size
  end

  def generate_label_id
    stored_labels = load_data_from_file('data/labels.json')
    stored_labels.size
  end

  def generate_author_id
    stored_authors = load_data_from_file('data/authors.json')
    stored_authors.size
  end

  def input_genre_id
    stored_genres = load_data_from_file('data/genres.json')
    stored_genres.size
  end

  def input_cover_condition
    loop do
      display_message('Enter the book cover condition (GOOD or BAD): ')
      cover_condition = gets.chomp.upcase
      return cover_condition if %w[GOOD BAD].include?(cover_condition)

      display_message('Invalid cover condition. Please enter either GOOD or BAD.')
    end
  end

  def store_genre(genre)
    genre_data = {
      id: genre.id,
      title: genre.name,
      item_ids: genre.items.map(&:id)
    }

    stored_genres = load_data_from_file('data/genres.json')
    stored_genres << genre_data
    write_data_to_file('data/genres.json', stored_genres)
  end

  def store_book(book)
    book_data = {
      id: book.id,
      publisher: book.publisher,
      publish_date: book.publish_date,
      cover_condition: book.cover_state,
      genre: book.genre.name,
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
      color: label.color,
      item_ids: label.items.map(&:id)
    }

    stored_labels = load_data_from_file('data/labels.json')
    stored_labels << label_data
    write_data_to_file('data/labels.json', stored_labels)
  end

  def store_author(author)
    author_data = {
      id: author.id,
      first_name: author.first_name,
      last_name: author.last_name,
      item_ids: author.items.map(&:id)
    }

    stored_authors = load_data_from_file('data/authors.json')
    stored_authors << author_data
    write_data_to_file('data/authors.json', stored_authors)
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

  def input_genre_name
    display_message('Enter the genre name: ')
    gets.chomp
  end

  def input_author_name
    display_message('Enter the book author\'s first name: ')
    first_name = gets.chomp
    display_message('Enter the book author\'s last name: ')
    last_name = gets.chomp
    [first_name, last_name]
  end

  def input_label_title
    display_message('Enter the book label: ')
    gets.chomp
  end

  def display_message(message, wrap_at = 80)
    lines = message.scan(/\S.{0,#{wrap_at - 2}}\S(?=\s|$)|\S+/)
    border_line = '═' * (wrap_at + 2)

    puts "╔#{border_line}╗"
    lines.each { |line| puts "║ #{line.ljust(wrap_at)} ║" }
    puts "╚#{border_line}╝"
  end
end
