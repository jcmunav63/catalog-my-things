require_relative '../author'
require 'rspec'
require_relative '../item'

RSpec.describe Author do
  describe '#initialize' do
    it 'creates an Author instance with correct attributes' do
      author = Author.new(1, 'John', 'Doe')

      expect(author.id).to eq(1)
      expect(author.first_name).to eq('John')
      expect(author.last_name).to eq('Doe')
      expect(author.items).to eq([])
    end
  end

  describe '#add_item' do
    it 'adds an item to the author' do
      author = Author.new(1, 'John', 'Doe')
      item = double('Item', author: nil)
      allow(item).to receive(:author=).with(author)

      author.add_item(item)

      expect(author.items).to include(item)
    end

    it 'does not add duplicate items' do
      author = Author.new(1, 'John', 'Doe')
      item = double('Item', author: nil)
      allow(item).to receive(:author=).with(author)

      author.add_item(item)
      author.add_item(item)

      expect(author.items.size).to eq(1)
    end
  end
end
