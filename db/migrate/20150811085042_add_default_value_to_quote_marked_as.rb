class AddDefaultValueToQuoteMarkedAs < ActiveRecord::Migration
  def change
    change_column :quotes, :marked_as, :integer, default: 0
  end
end
