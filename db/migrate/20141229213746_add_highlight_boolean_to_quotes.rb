class AddHighlightBooleanToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :highlight, :boolean, :default => false
  end
end
