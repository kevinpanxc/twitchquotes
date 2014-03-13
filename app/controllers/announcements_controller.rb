class AnnouncementsController < ApplicationController
    before_filter :signed_in_user

    def create
        @announcement = Announcement.new(announcement_params)
        @announcement.expired = false

        if @announcement.save
            flash[:success] = "Successfully added announcement, should be displayed now"
            redirect_to admin_path
        else
            render 'users/admin'
        end
    end

    def update
        @announcement = Announcement.find(params[:id])
        if @announcement.update_attributes(announcement_params)
            flash[:success] = "Successfully updated announcement"
            redirect_to admin_path
        else
            render 'users/admin'
        end
    end

    private
        def announcement_params
            params.require(:announcement).permit(:content_unevaluated, :expired)
        end
end