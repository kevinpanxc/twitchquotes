class RemoveStreamNameStreamUrlColumnsFromQuotes < ActiveRecord::Migration
  def change
  	remove_column :quotes, :stream_url
  	remove_column :quotes, :stream_name
  end
end