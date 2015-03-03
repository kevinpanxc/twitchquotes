class CreateIpLikes < ActiveRecord::Migration
  def change
    create_table :ip_likes do |t|
      t.references :ip_user, index: true
      t.references :quote, index: true

      t.timestamps
    end

    add_index :ip_likes, [:ip_user_id, :quote_id], unique: true
  end
end
