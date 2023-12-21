require_relative '../games_manager'

RSpec.describe GamesManager do
  describe '#add_a_game' do
    it 'Adds a game to the games manager' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return(
        'Adventure', 'James', 'Martins', 'Online shop', 'Advanced', '2021-07-01', 'Yes', '2023-02-01'
      )
      games_manager = GamesManager.new
      initial_games_count = games_manager.games.length
      games_manager.add_a_game
      expect(games_manager.games.length).to eq(initial_games_count + 1)
      added_game = games_manager.games.last
      expect(added_game.genre.name).to eq('Adventure')
      expect(added_game.author.first_name).to eq('James')
      expect(added_game.author.last_name).to eq('Martins')
      expect(added_game.source).to eq('Online shop')
      expect(added_game.label.title).to eq('Advanced')
      expect(added_game.publish_date).to eq(Date.parse('2021-07-01'))
      expect(added_game.multiplayer).to eq('yes')
      expect(added_game.last_played_at).to eq(Date.parse('2023-02-01'))
    end
  end
end
