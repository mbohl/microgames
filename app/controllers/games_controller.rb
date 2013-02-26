
class GamesController < ApplicationController

	def new
		@game = Game.new
	end

	def create
	#Set entry vaues 
	@game = Game.new
	@game.type = 1
	@game.turn = session[:user_id]
	@game.last_turn = Time.now

	@player_ids = Array.new
	@player_ids.push(session[:user_id])
	@player_ids.push(params[:friend_id])

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
