class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
        t.string :quote
        t.references :ip_user, index: true

        t.timestamps
    end
  end
end
