class SessionsController < ApplicationController
	def create
		user = User.find_by(email:user_params[:email])
		if !user
			flash[:log_errors] = ["Email address not found"]
			redirect_to main_path
		elsif !user.authenticate(user_params[:password])
			flash[:log_errors] = ["Invalid password"]
			redirect_to main_path
		else
			session[:user_id] = user.id
			session[:name] = user.full_name
			flash[:success] = "You're now logged in"
			redirect_to groups_path
		end
	end

	def destroy
		session[:user_id] = nil
		session[:name] = nil
		flash[:log_success] = "You're now logged out"
		redirect_to main_path
	end

	private
	def user_params  #:doc:
		params.require(:user).permit(:email, :password)
	end
end
