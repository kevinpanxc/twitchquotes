class AddFakeIpLikesCountToQuotesTable < ActiveRecord::Migration
  def change
    add_column :quotes, :f_ip_likes, :integer, :default => 0
  end
end
