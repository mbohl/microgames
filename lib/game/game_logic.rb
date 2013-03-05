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

	def self.get_cell_owner(cell_state, game, curPN)

		if cell_state == '0'
			if game.turn != curPN
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

	def self.check_endgame(game_state, updated_index)

		n = 3
		col = updated_index.to_i % 3
		row = updated_index.to_i / 3

		#horizontal check
		if game_state[3 * row] == game_state[3 * row + 1] and game_state[3 * row + 1] == game_state[3 * row + 2]
			return game_state[3 * row]
		#vertical check
		elsif game_state[col + 3] == game_state[col] and game_state[col] == game_state[col + 6]
			return game_state[col]
		#diagonal checks
		elsif updated_index.to_i % 2 == 0
			if (game_state[0] == game_state[4] and game_state[4] == game_state[8]) or (game_state[2] == game_state[4] and game_state[4] == game_state[6])
				return game_state[0]
			end
		end

		return 0

	end

end