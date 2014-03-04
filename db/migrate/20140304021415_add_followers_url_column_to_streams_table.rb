class AddFollowersUrlColumnToStreamsTable < ActiveRecord::Migration
  def change
  	add_column :streams, :logo, :string
  	add_column :streams, :followers, :integer
  end
end
