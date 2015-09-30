class AddIndexToEmoticonTable < ActiveRecord::Migration
  def change
      add_index :emoticons, :string_id
  end
end
