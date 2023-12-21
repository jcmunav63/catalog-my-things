require_relative '../item'
require_relative '../author'
require_relative '../genre'
require_relative '../label'
require_relative '../book'

describe Book do
  before(:each) do
    author = Author.new(1, 'J.K. Rowling', 'Jay')
    genre = Genre.new(1, 'Fiction')
    label = Label.new(1, 'Bestseller', 'Red')

    @book = Book.new(id: 1, genre: genre, author: author, source: 'Library',
                     label: label, publish_date: '2000-07-08', publisher: 'Bloomsbury', cover_state: 'bad')
  end

  context '#can_be_archived?' do
    it 'calls the superclass method' do
      expect_any_instance_of(Item).to receive(:can_be_archived?)
      @book.can_be_archived?
    end
  end
end
