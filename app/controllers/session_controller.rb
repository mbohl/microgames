
class SessionController < ApplicationController

	def new
		render 'session/new'
	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.password == params[:session][:password] 
			session[:user_id] = user.id
			redirect_to home_path(session[:user_id])
		else
			flash.now[:error] = 'Invalid login information'
			redirect_to "/"
		end

		#else
		#	flash.now[:error] = 'Invalid email/password combination'
		#	render 'new'
		#end
	end

	def destroy
		session[:user_id] = nil
		puts "--------------------------------------------------------"
		puts "SESSION ID"
		puts session[:user_id]
		redirect_to signin_path
	end

end
