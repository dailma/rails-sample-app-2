class MembersController < ApplicationController
	def create
		Member.create(org:Org.find(params[:org].to_i), user:current_user)
		redirect_to groups_path
	end

	def destroy
		Member.find(params[:id].to_i).destroy
		redirect_to groups_path
	end
end
