require_relative '../musicalbum_manager'

RSpec.describe AlbumManager do
  describe '#add_a_music_album' do
    it 'Adds a music album to the music album manager' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return(
        'Rock', 'John', 'Doe', 'Online shop', 'New Label', '2022-01-01', 'true'
      )
      album_manager = AlbumManager.new
      initial_albums_count = album_manager.musicalbums.length
      album_manager.add_a_music_album
      expect(album_manager.musicalbums.length).to eq(initial_albums_count + 1)
      added_album = album_manager.musicalbums.last
      expect(added_album.genre.name).to eq('Rock')
      expect(added_album.author.first_name).to eq('John')
      expect(added_album.author.last_name).to eq('Doe')
      expect(added_album.source).to eq('Online shop')
      expect(added_album.label.title).to eq('New Label')
      expect(added_album.publish_date).to eq(Date.parse('2022-01-01'))
      expect(added_album.on_spotify).to be(true)
    end
  end
end
