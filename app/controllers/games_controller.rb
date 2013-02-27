
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
	@game.type = 1
	@game.turn = session[:user_id]
	@game.last_turn = Time.now
	@game.state = '000000000'

	@player_ids = Array.new
	@player_ids.push(session[:user_id])

	params.each do |cur_param|
		if cur_param[0].starts_with? 'friend'
			@player_ids.push(cur_param[0].split('.')[1])
		end
	end

	if @game.save
	#eventually change to association based entity creation
		GameLogic.create_new_game(@player_ids, @game.id)
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

end
