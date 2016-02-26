class CreateQuoteTags < ActiveRecord::Migration
    def change
        create_table :quote_tags do |t|
            t.string :name, index: true

            t.timestamps
        end
        add_reference :quotes, :quote_tag, index: true
    end
end
