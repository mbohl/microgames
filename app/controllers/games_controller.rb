
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
		    	format.html { redirect_to showuser_path(session[:user_id]), :notice => 'Game was successfully created.' }
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

		#get hash of cell_states (X, O, Empty)
		@cellStates = Hash.new
		for i in 0..8
			@cellStates[i] = TicLogic.get_cell_owner(@game.game_state[i], @game, @curPN.to_i)
		end

		respond_to do |format|
      		format.html # show.html.erb
      		format.json { render :json => @user }
    	end
	end

	def change_state
		
		game = Game.find_by_id(params[:game_id])

		if(game.gametype == 1)
			game = TicLogic.change_state(params[:state_index], params[:game_id], session[:user_id])
		end

		redirect_to :action => "show", :id => game.id
	end

end
