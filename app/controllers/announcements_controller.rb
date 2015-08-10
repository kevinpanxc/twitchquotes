class AnnouncementsController < ApplicationController
    before_filter :is_admin

    def index
        @announcements = Announcement.order("created_at desc").paginate(page: params[:page], per_page: 10)
    end

    def toggle_expire
        latest = Announcement.last
        latest.expired = !latest.expired
        latest.save
        redirect_to :back
    end

    def new
        @announcement = Announcement.new
    end

    def create
        @announcement = Announcement.new(announcement_params)
        @announcement.expired = false

        if @announcement.save
            flash[:success] = "Successfully added announcement, should be displayed now"
            redirect_to admin_index_path
        else
            render 'new'
        end
    end

    def edit
        @announcement = Announcement.find(params[:id])
    end

    def update
        @announcement = Announcement.find(params[:id])
        if @announcement.update_attributes(announcement_params)
            flash[:success] = "Successfully updated announcement"
            redirect_to :back
        else
            render 'edit'
        end
    end

    private
        def announcement_params
            params.require(:announcement).permit(:content_unevaluated, :expired)
        end
end