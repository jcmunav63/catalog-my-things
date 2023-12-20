require_relative '../item'
require_relative '../book'

describe Book do
  before(:each) do
    @book = Book.new(id: 1, genre: 'Fiction', author: 'J.K. Rowling', source: 'Library',
                     label: nil, publish_date: '2000-07-08', publisher: 'Bloomsbury', cover_state: 'Good')
  end

  context '#can_be_archived?' do
    it 'calls the superclass method' do
      expect_any_instance_of(Item).to receive(:can_be_archived?)
      @book.can_be_archived?
    end
  end
end
