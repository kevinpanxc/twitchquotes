class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :name
      t.string :stream_id
      t.integer :followers
      t.string :url
      t.string :logo

      t.timestamps
    end
  end
end
