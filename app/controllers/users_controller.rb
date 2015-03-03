class UsersController < ApplicationController
    before_filter :signed_in_user, only: [:admin, :toggle_social]
    before_filter :is_admin, only: [:admin, :toggle_social]

    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])

        @which_quotes = params.has_key?(:which) ? params[:which] : "like"

        if @which_quotes == "like"
            @links = @user.likes.paginate(page: params[:page], :per_page => 24, order: "created_at DESC")
        else
            @links = @user.dislikes.paginate(page: params[:page], :per_page => 24, order: "created_at DESC")
        end

        @like_count = @user.likes.count
        @dislike_count = @user.dislikes.count

        @quotes = @links.map { |link| link.quote }
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
        @display_social = Rails.application.config.display_social
        @display_ip_voting = Rails.application.config.display_ip_voting
    end

    def toggle_social
        if params[:social] == 'true'
            Rails.application.config.display_social = true
        else
            Rails.application.config.display_social = false
        end
        flash[:success] = "Display social settings toggled to #{params[:social]}"
        redirect_to admin_path
    end

    def toggle_ip_voting
        if params[:ip_voting] == 'true'
            Rails.application.config.display_ip_voting = true
        else
            Rails.application.config.display_ip_voting = false
        end
        flash[:success] = "Display ip voting settings toggled to #{params[:ip_voting]}"
        redirect_to admin_path
    end

    private
        def user_params
            params.require(:user).permit(:username, :email, :password, :password_confirmation)
        end
end