require_relative '../item'
require_relative '../genre'
require_relative '../author'
require_relative '../label'

describe Item do
  before :each do
    @genre = Genre.new(1, 'Thriller')
    @author = Author.new(1, 'Stephen', 'King')
    @label = Label.new(1, 'Bestseller', 'Red')
  end

  context '#initialize' do
    it 'Creates a new item with the correct properties' do
      item = Item.new(1, @genre, @author, 'Online shop', @label, Time.new(2020, 1, 1))
      expect(item).to be_an_instance_of(Item)
      expect(item.genre).to eq(@genre)
      expect(item.author).to eq(@author)
      expect(item.label).to eq(@label)
      expect(item.publish_date).to eq(Time.new(2020, 1, 1))
    end
  end

  context '#can_be_archived?' do
    it 'Returns true if the item can be archived' do
      item = Item.new(1, @genre, @author, 'Shop', @label, Time.new(2010, 1, 1))
      expect(item.can_be_archived?).to be true
    end

    it 'Returns false if the item cannot be archived' do
      item = Item.new(1, @genre, @author, 'Shop', @label, Time.new(2022, 1, 1))
      expect(item.can_be_archived?).to be false
    end
  end

  context '#move_to_archive' do
    it 'Archives the item if it can be archived' do
      item = Item.new(1, @genre, @author, 'Online shop', @label, Time.new(2010, 1, 1))
      item.move_to_archive
      expect(item.archived).to be true
    end

    it 'Does not archive the item if it cannot be archived' do
      item = Item.new(1, @genre, @author, 'Online shop', @label, Time.new(2022, 1, 1))
      item.move_to_archive
      expect(item.archived).to be false
    end
  end
end
