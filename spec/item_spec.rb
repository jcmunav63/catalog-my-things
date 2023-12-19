require_relative '../item'
require 'rspec'

RSpec.describe Item do
  describe '#initialize' do
    it 'Creates a new item with the correct properties' do
      item = Item.new('Thriller', 'Stephen King', 'Online shop', 'New', Time.new(2020, 1, 1))
      expect(item.genre).to eq('Thriller')
      expect(item.author).to eq('Stephen King')
      expect(item.source).to eq('Online shop')
      expect(item.label).to eq('New')
      expect(item.publish_date).to eq(Time.new(2020, 1, 1))
      expect(item.archived).to be(false)
    end
  end

  describe '#can_be_archived?' do
    it 'Returns true if the item can be archived' do
      item = Item.new('Action', 'James Cameron', 'Shop', 'From friend', Time.new(2010, 1, 1))
      expect(item.can_be_archived?).to be(true)
    end

    it 'Returns false if the item cannot be archived' do
      item = Item.new('Action', 'James Cameron', 'Shop', 'From friend', Time.new(2022, 1, 1))
      expect(item.can_be_archived?).to be(false)
    end
  end

  describe '#move_to_archive' do
    it 'Archives the item if it can be archived' do
      item = Item.new('Drama', 'John Scott', 'Online shop', 'Gift', Time.new(2010, 1, 1))
      item.move_to_archive
      expect(item.archived).to be(true)
    end

    it 'Does not archive the item if it cannot be archived' do
      item = Item.new('Drama', 'John Scott', 'Online shop', 'Gift', Time.new(2022, 1, 1))
      item.move_to_archive
      expect(item.archived).to be(false)
    end
  end
end
