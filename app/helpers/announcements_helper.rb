module AnnouncementsHelper
    def has_announcement?
        Announcement.last && !Announcement.last.expired?
    end

    def has_announcement_in_db?
        Announcement.last
    end

    def latest_announcement
        Announcement.last.content
    end
end
