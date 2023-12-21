require_relative '../item'
require_relative '../book_manager'

describe BookManager do
  before(:each) do
    @book_manager = BookManager.new
    allow(@book_manager).to receive(:puts)
  end

  describe '#add_a_book' do
    before do
      # Stubbing user input methods
      allow(@book_manager).to receive(:input_book_color).and_return('Red')
      allow(@book_manager).to receive(:input_publish_date).and_return('2020-01-01')
      allow(@book_manager).to receive(:input_publisher).and_return('Publisher')
      allow(@book_manager).to receive(:input_author).and_return('Author')
      allow(@book_manager).to receive(:input_label_title).and_return('Label Title')
      allow(@book_manager).to receive(:input_cover_condition).and_return('GOOD')

      # Stubbing methods that interact with files
      allow(@book_manager).to receive(:store_book)
      allow(@book_manager).to receive(:store_label)
      allow(@book_manager).to receive(:generate_book_id).and_return(1)
      allow(@book_manager).to receive(:generate_label_id).and_return(1)
    end

    it 'adds a book to the books array' do
      expect { @book_manager.add_a_book }.to change { @book_manager.books.length }.by(1)
    end

    it 'adds a label to the labels array' do
      expect { @book_manager.add_a_book }.to change { @book_manager.labels.length }.by(1)
    end
  end

  describe '#generate_book_id' do
    it 'returns the next book ID based on stored books' do
      allow(@book_manager).to receive(:load_data_from_file).with('data/books.json').and_return([{ 'id' => 1 },
                                                                                                { 'id' => 2 }])
      expect(@book_manager.generate_book_id).to eq(2)
    end
  end

  describe '#generate_label_id' do
    it 'returns the next label ID based on stored labels' do
      allow(@book_manager).to receive(:load_data_from_file).with('data/labels.json').and_return([{ 'id' => 1 }])
      expect(@book_manager.generate_label_id).to eq(1)
    end
  end
  describe '#store_book' do
    it 'stores book data to a file' do
      book = instance_double('Book', id: 1, publisher: 'Publisher', publish_date: '2020-01-01', cover_state: 'Good',
                                     genre: nil, author: 'Author',
                                     source: nil,
                                     label: instance_double('Label', title: 'Label Title'), archived: false)
      allow(@book_manager).to receive(:write_data_to_file)

      @book_manager.store_book(book)
      expect(@book_manager).to have_received(:write_data_to_file).with('data/books.json', anything)
    end
  end

  describe '#store_label' do
    it 'stores label data to a file' do
      label = Label.new(1, 'Label Title', 'Red')
      allow(@book_manager).to receive(:write_data_to_file)

      @book_manager.store_label(label)
      expect(@book_manager).to have_received(:write_data_to_file).with('data/labels.json', anything)
    end
  end

  describe '#load_data_from_file' do
    it 'loads data from an existing file' do
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:read).and_return('[{"id":1}]')

      data = @book_manager.load_data_from_file('some_file.json')
      expect(data).to eq([{ 'id' => 1 }])
    end

    it 'returns an empty array if file does not exist' do
      allow(File).to receive(:exist?).and_return(false)
      expect(@book_manager.load_data_from_file('nonexistent_file.json')).to eq([])
    end
  end

  describe '#write_data_to_file' do
    it 'writes data to a file' do
      allow(FileUtils).to receive(:mkdir_p)
      allow(File).to receive(:write)

      @book_manager.write_data_to_file('some_file.json', [{ 'id' => 1 }])
      expect(File).to have_received(:write).with('some_file.json', anything)
    end
  end

  describe '#list_all_books' do
    it 'processes and displays all books' do
      mock_books_data = [
        { 'id' => 0, 'publisher' => 'Publisher', 'publish_date' => '2020-02-02', 'cover_condition' => 'GOOD',
          'author' => 'Author', 'label' => 'label' },
        { 'id' => 1, 'publisher' => 'Publisher2', 'publish_date' => '2525-02-02', 'cover_condition' => 'BAD',
          'author' => 'Author2', 'label' => 'Label2' }
      ]
      allow(@book_manager).to receive(:load_data_from_file).with('data/books.json').and_return(mock_books_data)
      allow(@book_manager).to receive(:display_message)

      @book_manager.list_all_books

      expect(@book_manager).to have_received(:display_message).with(/Book id: 0/)
      expect(@book_manager).to have_received(:display_message).with(/Book id: 1/)
    end
  end

  describe '#list_all_labels' do
    it 'processes and displays all labels' do
      mock_labels_data = [
        { 'id' => 0, 'title' => 'label', 'color' => 'Color', 'item_ids' => [0] },
        { 'id' => 1, 'title' => 'Label2', 'color' => 'Color2', 'item_ids' => [1] }
      ]
      allow(@book_manager).to receive(:load_data_from_file).with('data/labels.json').and_return(mock_labels_data)
      allow(@book_manager).to receive(:display_message)

      @book_manager.list_all_labels

      expect(@book_manager).to have_received(:display_message).with(/Label: label/)
      expect(@book_manager).to have_received(:display_message).with(/Label: Label2/)
    end
  end
end
