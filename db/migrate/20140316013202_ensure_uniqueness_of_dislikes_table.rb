class EnsureUniquenessOfDislikesTable < ActiveRecord::Migration
  def change
    add_index :dislikes, [:facebook_user_id, :quote_id], unique: true
  end
end