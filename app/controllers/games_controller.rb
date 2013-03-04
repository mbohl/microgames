
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
			@game.turn = 1
		else
			@game.turn = 1
		end

		@game.last_turn = Time.now

		#update the appropriate index in the state variable
		playerNumber = GameLogic.get_player_number(@game.id, session[:user_id])
		curState = @game.game_state

		puts "OLD ENCODING"
		puts curState.encoding

		newState = String.new

		print "NEW STATE:\n"
		print newState
		print "\n"
		newState = curState

		newState[2] = '1'

		puts 'NEW ENCODING'
		puts newState.encoding
		@game.game_state[2] = '1'

		puts "GAMESTATE:"
		puts @game.game_state

		#save the updated record
		if @game.save!
			puts "SAVED!!!"
		else
			puts "NOT SAVED!!!"
		end

		#@game = Game.find(params[:game_id]).reload
		puts "new game state?"
		puts @game.game_state

		redirect_to :action => "show", :id => @game.id
	end

end
