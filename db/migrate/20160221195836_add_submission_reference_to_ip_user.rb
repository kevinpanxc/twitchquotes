class AddSubmissionReferenceToIpUser < ActiveRecord::Migration
    def change
        add_column :ip_users, :recent_submissions_count, :integer, null: false, default: 0
        add_column :ip_users, :last_day, :timestamp
    end
end
