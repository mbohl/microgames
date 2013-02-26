module GameLogic

	def self.create_new_game(player_ids, game_id)

		player_ids.each do |id|
			@games_user = GamesUser.new
			@games_user.game_id = game_id
			@games_user.user_id = id
			#need error check too
			@games_user.save
		end

	end

end