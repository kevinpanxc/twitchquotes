class FacebookUserToUserLikesDislikesTable < ActiveRecord::Migration
  def change
    remove_column :likes, :facebook_user_id
    add_reference :likes, :user, index: true

    remove_column :dislikes, :facebook_user_id
    add_reference :dislikes, :user, index: true
  end
end