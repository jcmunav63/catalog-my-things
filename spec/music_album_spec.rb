require_relative '../item'
require_relative '../music_album'
require 'rspec'

RSpec.describe MusicAlbum do
  describe '#initialize' do
    it 'Creates a new music album with the correct properties' do
      music_album = MusicAlbum.new(
        genre: 'Rock',
        author: 'Bon Jovi',
        source: 'From friend',
        label: 'Gift',
        publish_date: Time.new(2020, 1, 1),
        on_spotify: true
      )
      expect(music_album.genre).to eq('Rock')
      expect(music_album.author).to eq('Bon Jovi')
      expect(music_album.source).to eq('From friend')
      expect(music_album.label).to eq('Gift')
      expect(music_album.publish_date).to eq(Time.new(2020, 1, 1))
      expect(music_album.archived).to be(false)
      expect(music_album.on_spotify).to be(true)
    end
  end

  describe '#can_be_archived?' do
    it 'Returns true if the music album can be archived' do
      music_album = MusicAlbum.new(
        genre: 'Pop',
        author: 'Madonna',
        source: 'Online shop',
        label: 'New',
        publish_date: Time.new(2010, 1, 1),
        on_spotify: true
      )
      expect(music_album.can_be_archived?).to be(true)
    end

    it 'Returns false if the music album is not on spotify' do
      music_album = MusicAlbum.new(
        genre: 'Pop',
        author: 'Sting',
        source: 'Online shop',
        label: 'New',
        publish_date: Time.new(2010, 1, 1),
        on_spotify: false
      )
      expect(music_album.can_be_archived?).to be(false)
    end

    it 'Returns false if the music album publish_date is not older than 10 years' do
      music_album = MusicAlbum.new(
        genre: 'Pop',
        author: 'Genesis',
        source: 'Online shop',
        label: 'New',
        publish_date: Time.new(2020, 1, 1),
        on_spotify: true
      )
      expect(music_album.can_be_archived?).to be(false)
    end
  end
end
