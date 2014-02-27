class RemoveStreamsFollowersLogoColumn < ActiveRecord::Migration
  def change
  	remove_column :streams, :logo
  	remove_column :streams, :followers
  end
end
