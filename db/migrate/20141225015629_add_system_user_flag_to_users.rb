class AddSystemUserFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :system_user, :boolean, :default => false
  end
end
