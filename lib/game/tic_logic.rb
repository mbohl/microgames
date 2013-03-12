module TicLogic

	def self.change_state(state_index, game_id, user_id)
		@game = Game.find_by_id(game_id)

		#switch turn
		if @game.turn == 1
			@game.turn = 2
		else
			@game.turn = 1
		end

		@game.last_turn = Time.now

		#update the appropriate index in the state variable
		playerNumber = GameLogic.get_player_number(@game.id, user_id)

		@game.game_state_will_change!
		@game.game_state[Integer(state_index)] = playerNumber[0].player_number.to_s

		endcheck = check_endgame(@game.game_state, state_index)

		if endcheck.to_i > 0
			@game.winner_will_change!
			@game.winner = endcheck
		end

		puts "SAVING!!!!!!!!!!!!"
		#save updated object
		@game.save
		return @game

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