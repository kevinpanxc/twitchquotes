class ChangeUsernameLengthLimit < ActiveRecord::Migration
  def self.up
    change_column :users, :username, :string, limit: 24
  end

  def self.down
    change_column :users, :username, :string, limit: 255
  end
end
