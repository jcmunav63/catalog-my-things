require_relative '../genre'
require_relative '../item'
require 'rspec'

RSpec.describe Genre do
  describe '#initialize' do
    it 'Creates a new genre with the correct properties' do
      genre = Genre.new('Rock')
      expect(genre.name).to eq('Rock')
      expect(genre.id).to be_a(Integer)
      expect(genre.items).to be_an(Array)
    end
  end

  describe '#add_item' do
    it 'Adds an item to the genre' do
      genre = Genre.new('Action')
      item = Item.new('Action', 'Clint Eastwood', 'Online shop', 'New', Time.new(2020, 1, 1))
      genre.add_item(item)
      expect(genre.items).to include(item)
    end
  end
end
