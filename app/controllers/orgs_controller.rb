class OrgsController < ApplicationController
	def index
		if !current_user
			flash[:log_errors] = ["Please sign in"]
			redirect_to main_path
		else
			user = current_user
			@name = user.name_first + " " + user.name_last
			orgs = Org.all
			@groups = []
			orgs.each do |org|
				@groups << [org.id, org.name, (org.owner == user), org.users.count, org.description]
			end
		end
	end

	def show
		@org = Org.find(params[:id])
		owner = @org.owner
		signed_in = current_user
		if owner == signed_in
			@name = "You"
		else
			@name = owner.full_name
		end
		@members = []
		@memid = nil
		@org.users.each do |user|
			@members << user.full_name
			if user == signed_in
				@memid = @org.members.find_by(user:user).id
			end
		end
		@members << "None" if @members === []
	end

	def create
		org = Org.new(org_params)
		org.owner = current_user
		if org.invalid?
			flash[:reg_errors] = org.errors.full_messages
			redirect_to groups_path
		else
			org.save
			Member.create(org:org, user:current_user)
			flash[:success] = "Organization created"
			redirect_to groups_path
		end
	end

	def destroy
		org = Org.find(params[:id])
		if org.owner != current_user
			flash[:errors] = ["That's not your organziation!"]
			redirect_to groups_path
		else
			org.destroy
			flash[:success] = "Organization deleted"
			redirect_to groups_path
		end
	end

	private
	def org_params  #:doc:
		params.require(:org).permit(:name, :description)
	end
end
