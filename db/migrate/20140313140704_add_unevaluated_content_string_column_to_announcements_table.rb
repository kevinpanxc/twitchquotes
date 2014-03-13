class AddUnevaluatedContentStringColumnToAnnouncementsTable < ActiveRecord::Migration
  def change
    add_column :announcements, :content_unevaluated, :text, :limit => nil
  end
end