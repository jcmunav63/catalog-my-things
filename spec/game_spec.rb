require_relative '../item'
require_relative '../game'
require 'rspec'

RSpec.describe Game do
  describe '#initialize' do
    it 'Creates a new music album with the correct properties' do
      label_instance = Label.new(8, 'New', 'Blue')
      genre_instance = Genre.new(6, 'Action')
      author_instance = Author.new(5, 'New Horizon', 'Games')
      game = Game.new(
        id: 16,
        genre: genre_instance,
        author: author_instance,
        source: 'Online',
        label: label_instance,
        publish_date: Time.new(2021, 3, 7),
        multiplayer: 'yes',
        last_played_at: Time.new(2022, 4, 9)
      )
      expect(game.id).to eq(16)
      expect(game.genre).to eq(genre_instance)
      expect(game.author).to eq(author_instance)
      expect(game.source).to eq('Online')
      expect(game.label).to eq(label_instance)
      expect(game.publish_date).to eq(Time.new(2021, 3, 7))
      expect(game.multiplayer).to eq('yes')
      expect(game.last_played_at).to eq(Time.new(2022, 4, 9))
    end
  end

  describe '#can_be_archived?' do
    it 'Returns true' do
      label_instance = Label.new(10, 'New', 'Blue')
      genre_instance = Genre.new(8, 'Adventure')
      author_instance = Author.new(7, 'High End', 'Games')
      game = Game.new(
        id: 1,
        genre: genre_instance,
        author: author_instance,
        source: 'Digital Store',
        label: label_instance,
        publish_date: Time.new(2011, 2, 1),
        multiplayer: true,
        last_played_at: Time.new(2020, 7, 1)
      )
      expect(game.can_be_archived?).to be(true)
    end

    it 'Returns false' do
      label_instance = Label.new(12, 'New', 'Blue')
      genre_instance = Genre.new(10, 'Quest')
      author_instance = Author.new(9, 'Bkue', 'Star')
      game = Game.new(
        id: 7,
        genre: genre_instance,
        author: author_instance,
        source: 'Online Store',
        label: label_instance,
        publish_date: Time.new(2020, 2, 1),
        multiplayer: true,
        last_played_at: Time.new(2021, 7, 1)
      )
      expect(game.can_be_archived?).to be(false)
    end
  end
end
