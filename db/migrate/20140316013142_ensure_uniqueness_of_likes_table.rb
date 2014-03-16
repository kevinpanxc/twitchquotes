class EnsureUniquenessOfLikesTable < ActiveRecord::Migration
  def change
    add_index :likes, [:facebook_user_id, :quote_id], unique: true
  end
end