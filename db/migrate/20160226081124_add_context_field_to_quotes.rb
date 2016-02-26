class AddContextFieldToQuotes < ActiveRecord::Migration
    def change
        add_column :quotes, :context, :string, null: true, default: nil
    end
end
