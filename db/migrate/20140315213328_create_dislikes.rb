class CreateDislikes < ActiveRecord::Migration
  def change
    create_table :dislikes do |t|
      t.references :facebook_user, index: true
      t.references :quote, index: true

      t.timestamps
    end
  end
end