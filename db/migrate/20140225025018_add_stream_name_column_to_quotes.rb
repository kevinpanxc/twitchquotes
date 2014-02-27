class AddStreamNameColumnToQuotes < ActiveRecord::Migration
  def change
  	add_column :quotes, :stream_name, :string
  end
end
