class ChangeStringColumnToTextColumnInQuotesTableForQuote < ActiveRecord::Migration
  def change
    change_column :quotes, :quote, :text, :limit => nil
	def down
	    # This might cause trouble if you have strings longer
	    # than 255 characters.
	    change_column :quotes, :quote, :string
	end
  end
end
