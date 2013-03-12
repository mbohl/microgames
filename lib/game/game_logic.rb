module GameLogic

	def self.create_games_users(player_ids, game_id)

		#for now, player_numbers are sequential integers; later give user/system capability to specify turn order
		curPN = 1
		player_ids.each do |id|
			games_user = GamesUser.new
			games_user.game_id = game_id
			games_user.player_number = curPN
			curUser = User.find_by_id(id)
			curUser.games_users.push(games_user)
			curUser.save
			curPN = curPN + 1
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

	def self.get_game_name(gametype)
		if gametype == '1'
			return 'Tic-Tac-Toe'
		else
			return 'Unknown Game'
		end
	end

	def self.get_player_number(game_id, user_id)
		print "GAME ID\n"
		print game_id

		print "USER_ID\n"
		print user_id

		player_number = GamesUser.find(:all,
										:conditions => ["games_users.game_id = ? and games_users.user_id = ?", game_id, user_id],
										:select => "games_users.player_number")
	end

	

end