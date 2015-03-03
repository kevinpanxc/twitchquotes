class EnsureUniquenessOfLikesDislikesTableNormalUser < ActiveRecord::Migration
  def change
    add_index :likes, [:user_id, :quote_id], unique: true
    add_index :dislikes, [:user_id, :quote_id], unique: true
  end
end
