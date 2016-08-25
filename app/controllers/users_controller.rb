class UsersController < ApplicationController
	def new
		if current_user
			flash[:errors] = ["You're already signed in as #{current_user.name_first} #{current_user.name_last}"]
			redirect_to groups_path
		end
	end

	def create
		user = User.new(user_params)
		if user.invalid?
			flash[:reg_errors] = []
			user.errors.each do |attr, msg|
				case attr  # modifies errors from SecurePassword
				when :password
					flash[:reg_errors] << "Password #{msg}" if msg != "can't be blank"
				when :password_confirmation
					flash[:reg_errors] << "Password and password confirmation don't match"
				else
					flash[:reg_errors] << msg
				end
			end
			redirect_to main_path
		else
			user.save
			session[:user_id] = user.id
			session[:name] = user.full_name
			flash[:success] = "Your account is ready for use"
			redirect_to groups_path
		end
	end

	private
	def user_params  #:doc:
		params.require(:user).permit(:name_first, :name_last, :email, :password, :password_confirmation)
	end
end
