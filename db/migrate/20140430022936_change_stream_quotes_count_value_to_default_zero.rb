class ChangeStreamQuotesCountValueToDefaultZero < ActiveRecord::Migration
  def change
    change_column :streams, :quotes_count, :integer, :default => 0
  end
end
