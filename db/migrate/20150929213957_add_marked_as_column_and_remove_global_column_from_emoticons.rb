class AddMarkedAsColumnAndRemoveGlobalColumnFromEmoticons < ActiveRecord::Migration
    def self.up
        add_column :emoticons, :marked_as, :integer, default: 0
        remove_column :emoticons, :global
    end

    def self.down
        remove_column :emoticons, :marked_as
        add_column :emoticons, :global, :boolean
    end
end
