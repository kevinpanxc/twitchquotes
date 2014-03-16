class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :facebook_user, index: true
      t.references :quote, index: true

      t.timestamps
    end
  end
end
