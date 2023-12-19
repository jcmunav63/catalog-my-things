require_relative 'book_manager'

class Catalog
  def initialize
    @book_manager = Bookmanager.new
    @items = []
    @labels = []
  end

  def list_all_books
    @book_manager.list_all_books
  end

  def list_all_labels
    @book_manager.list_all_labels
  end

  def add_a_book
    @book_manager.add_a_book
  end
end
