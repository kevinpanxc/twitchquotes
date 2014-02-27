class AddStreamUrlIdColumnsToQuotes < ActiveRecord::Migration
  def change
  	add_column :quotes, :stream_url, :string
  	add_column :quotes, :stream_id, :string
  end
end