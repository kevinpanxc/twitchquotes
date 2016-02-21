class AddInUseFieldToEmoticons < ActiveRecord::Migration
  def change
    add_column :emoticons, :in_use, :boolean, :default => false
  end
end
