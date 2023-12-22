require_relative '../item'
require_relative '../music_album'
require 'rspec'

RSpec.describe MusicAlbum do
  describe '#initialize' do
    it 'Creates a new music album with the correct properties' do
      label_instance = Label.new(8, 'New', 'Blue')
      genre_instance = Genre.new(6, 'Pop')
      author_instance = Author.new(5, 'Michael', 'Jackson')
      music_album = MusicAlbum.new(
        genre: genre_instance,
        author: author_instance,
        source: 'From friend',
        label: label_instance,
        publish_date: Time.new(2020, 1, 1),
        on_spotify: true
      )
      expect(music_album.genre.name).to eq('Pop')
      expect(music_album.author.first_name).to eq('Michael')
      expect(music_album.author.last_name).to eq('Jackson')
      expect(music_album.source).to eq('From friend')
      expect(music_album.label.title).to eq('New')
      expect(music_album.publish_date).to eq(Time.new(2020, 1, 1))
      expect(music_album.archived).to be(false)
      expect(music_album.on_spotify).to be(true)
    end
  end

  describe '#can_be_archived?' do
    it 'Returns true if the music album can be archived' do
      label_instance = Label.new(8, 'New', 'Blue')
      genre_instance = Genre.new(6, 'Pop')
      author_instance = Author.new(5, 'Michael', 'Jackson')
      music_album = MusicAlbum.new(
        genre: genre_instance,
        author: author_instance,
        source: 'Online shop',
        label: label_instance,
        publish_date: Time.new(2012, 2, 2),
        on_spotify: true
      )
      expect(music_album.can_be_archived?).to be(true)
    end

    it 'Returns false if the music album is not on spotify' do
      label_instance = Label.new(9, 'Used', 'Red')
      genre_instance = Genre.new(7, 'Pop')
      author_instance = Author.new(6, 'Sting', '')
      music_album = MusicAlbum.new(
        genre: genre_instance,
        author: author_instance,
        source: 'Physical shop',
        label: label_instance,
        publish_date: Time.new(2011, 5, 6),
        on_spotify: false
      )
      expect(music_album.can_be_archived?).to be(false)
    end

    it 'Returns false if the music album publish_date is not older than 10 years' do
      label_instance = Label.new(10, 'New', 'Blue')
      genre_instance = Genre.new(8, 'Rock')
      author_instance = Author.new(7, 'Bryan', 'Adams')
      music_album = MusicAlbum.new(
        genre: genre_instance,
        author: author_instance,
        source: 'Shop',
        label: label_instance,
        publish_date: Time.new(2021, 1, 1),
        on_spotify: true
      )
      expect(music_album.can_be_archived?).to be(false)
    end
  end
end
