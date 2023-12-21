require_relative '../genre'
require_relative '../item'
require 'rspec'

RSpec.describe Genre do
  describe '#initialize' do
    it 'Creates a new Ggenre with the correct properties' do
      genre = Genre.new(1, 'Rock')
      expect(genre.id).to eq(1)
      expect(genre.name).to eq('Rock')
      expect(genre.items).to be_an(Array)
    end
  end

  describe '#add_item' do
    it 'Adds an item to the genre' do
      label_instance = Label.new(8, 'New', 'Blue')
      author_instance = Author.new(10, 'Clint', 'Eastwood')
      genre = Genre.new(2, 'Action')
      item = Item.new(1, genre, author_instance, 'Online shop', label_instance, Time.new(2020, 1, 1))
      genre.add_item(item)
      expect(genre.items).to include(item)
      expect(item.genre).to eq(genre)
    end
  end
end
