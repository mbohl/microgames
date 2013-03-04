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

	def self.get_game_name(gametype)
		if gametype == '1'
			return 'Tic-Tac-Toe'
		else
			return 'Unknown Game'
		end
	end

	def self.get_cell_owner(cell_state, turn, curUserId)
		print "Cell state: \n"
		print cell_state
		print "\n"
		if cell_state == '0'
			if turn != curUserId
				return "OPEN"
			else
				return 'Move Here'
			end
		elsif cell_state == '1'
			return 'X'
		elsif cell_state == '2'
			return 'O'
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