class AddCounterCacheToIpLikes < ActiveRecord::Migration
  def self.up
    add_column :quotes, :ip_likes_count, :integer, null: false, default: 0
    Quote.all.each do |quote|
        Quote.reset_counters(quote.id, :ip_likes)
    end
  end

  def self.down
    remove_column :quotes, :ip_likes_count
  end
end
