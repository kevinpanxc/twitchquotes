class CreateIpUsers < ActiveRecord::Migration
  def change
    create_table :ip_users do |t|
      t.string :ip_address

      t.timestamps
    end

    add_index :ip_users, :ip_address, unique: true
  end
end
