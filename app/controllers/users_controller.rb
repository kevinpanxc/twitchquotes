class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:admin]

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to @user
		else
			render 'new'
		end
	end

	def admin
		@announcement_update = Announcement.last
		@announcement = Announcement.new
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end