class UsersController < ApplicationController
    before_filter :signed_in_user, only: [:admin]
    before_filter :is_admin, only: [:admin]

    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
    end

    def create
        @success = true
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Successfully signed up!"
            sign_in @user

            if params.has_key?(:remote) && params[:remote]
                respond_to do |format|
                    format.js
                end
            else
                redirect_to quotes_path
            end
        else
            @success = false
            if params.has_key?(:remote) && params[:remote]
                respond_to do |format|
                    format.js
                end
            else
                render 'new'
            end
        end
    end

    def admin
        @announcement_update = Announcement.last
        @announcement = Announcement.new
    end

    private
        def user_params
            params.require(:user).permit(:username, :email, :password, :password_confirmation)
        end
end