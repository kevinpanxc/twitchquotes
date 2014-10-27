class AddProfanityIntegerToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :marked_as, :integer, null: true, default: nil
  end
end
