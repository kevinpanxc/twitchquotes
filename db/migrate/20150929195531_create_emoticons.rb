class CreateEmoticons < ActiveRecord::Migration
  def change
    create_table :emoticons do |t|
        t.string :string_id
        t.string :image_url
        t.boolean :global

        t.timestamps
    end
  end
end
