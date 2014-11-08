class AddTextArtFlagToQuotesTable < ActiveRecord::Migration
  def change
    add_column :quotes, :text_art, :boolean, :default => false
  end
end
