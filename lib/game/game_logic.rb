module GameLogic

	def self.create_games_users(player_ids, game_id)

		player_ids.each do |id|
			games_user = GamesUser.new
			games_user.game_id = game_id
			curUser = User.find_by_id(id)
			curUser.games_users.push(games_user)
			curUser.save
		end
	end

	def self.find_users_games(user_id)

		user = User.find_by_id(user_id)
		games = Array.new

		user.games_users.each do |g|
			curGame = Game.find_by_id(g.game_id)
			games.push(curGame)
		end

		return games

	end

end