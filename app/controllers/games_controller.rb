
class GamesController < ApplicationController

	def new
		@game = Game.new
		@friends = User.find_friends(session[:user_id])
		respond_to do |format|
			format.html #new.html.erb
			format.json { render :json => @game}
		end
	end

	def create
		#Set entry vaues 
		@game = Game.new
		@game.gametype = 1
		@game.turn = 1 #set turn to first player_number
		@game.last_turn = Time.now
		@game.game_state = '000000000'

		player_ids = Array.new
		player_ids.push(session[:user_id])

		params.each do |cur_param|
			if cur_param[0].starts_with? 'friend'
				player_ids.push(cur_param[0].split('.')[1])
			end
		end

		if @game.save
		#eventually change to association based entity creation
			GameLogic.create_games_users(player_ids, @game.id)
		else
		#error
		end

		respond_to do |format|
			if @game.id
		    	format.html { redirect_to home_path(session[:user_id]), :notice => 'Game was successfully created.' }
		    	format.json { render :json => @game, :status => :created}
		  	else
		    	format.html { render :action => "new" }
		    	format.json { render :json => @user.errors, :status => :unprocessable_entity }
		  	end
		end
	end

	def show
		@game = Game.find_by_id(params[:id])
		@curPN = GameLogic.get_player_number(@game.id, session[:user_id])

		respond_to do |format|
      		format.html # show.html.erb
      		format.json { render :json => @user }
    	end
	end

	def change_state

		@game = Game.find_by_id(params[:game_id])

		#switch turn
		if @game.turn == 1
			@game.turn = 2
		else
			@game.turn = 1
		end

		@game.last_turn = Time.now

		#update the appropriate index in the state variable
		playerNumber = GameLogic.get_player_number(@game.id, session[:user_id])

		@game.game_state_will_change!
		@game.game_state[Integer(params[:state_index])] = playerNumber[0].player_number.to_s

		puts "GAMESTATE:"
		puts @game.game_state

		#save updated object
		@game.save


		redirect_to :action => "show", :id => @game.id
	end

end
