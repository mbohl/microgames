
class UsersController < ApplicationController

	def new
		@user = User.new
		respond_to do |format|
			format.html #new.html.erb
			format.json { render :json => @user}
		end
	end

	def create
		@user = User.new(params[:user])

		respond_to do |format|
		  if @user.save
		    session[:user_id] = @user.id
		    format.html { redirect_to showuser_path(@user.id), :notice => 'User was successfully created.' }
		    format.json { render :json => @user, :status => :created, :location => @user }
		  else
		    format.html { render :action => "new" }
		    format.json { render :json => @user.errors, :status => :unprocessable_entity }
		  end
		end
	end

	def show

		@user = User.find(params[:id])
		@friends = User.find_friends(params[:id])
		@usersGames = GameLogic.find_users_games(params[:id])
		@usersPlayerNumbers = Hash.new

		@usersGames.each do |ug|
			temp = GameLogic.get_player_number(ug.id, params[:id])
			@usersPlayerNumbers[ug.id] = temp
		end


	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render :json => @user }
	    end
  	end

  	def view_profile
  		@user = User.find(params[:id])
  		@games = GameLogic.find_ended_games(params[:id])

  		@numwins = 0
  		@numlosses = 0
  		@numdraws = 0

  		@games.each do |g|
  			if g.winner.to_i == @user.id.to_i
  				@numwins = @numwins + 1
  			elsif g.winner.to_i < 3
  				@numlosses = @numlosses + 1
  			else
  				@numdraws = @numdraws + 1
  			end
  		end

  		respond_to do |format|
	      format.html 
	      format.json { render :json => @user }
	    end

  	end

end
