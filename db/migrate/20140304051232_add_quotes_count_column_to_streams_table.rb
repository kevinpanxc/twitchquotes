class AddQuotesCountColumnToStreamsTable < ActiveRecord::Migration
  def change
  	add_column :streams, :quotes_count, :integer
  end
end