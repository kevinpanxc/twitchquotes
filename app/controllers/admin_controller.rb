class AdminController < ApplicationController
    before_filter :is_admin

    def index
        @announcements = Announcement.last(5).reverse
        @announcement_update = Announcement.last
        @announcement = Announcement.new
        @display_social = Rails.application.config.display_social
        @display_ip_voting = Rails.application.config.display_ip_voting
    end

    def toggle_social
        Rails.application.config.display_social = !Rails.application.config.display_social
        flash[:success] = "Display social settings toggled to #{Rails.application.config.display_social}"
        redirect_to admin_index_path
    end

    def toggle_ip_voting
        Rails.application.config.display_ip_voting = !Rails.application.config.display_ip_voting
        flash[:success] = "Display ip voting settings toggled to #{Rails.application.config.display_ip_voting}"
        redirect_to admin_index_path
    end
end
