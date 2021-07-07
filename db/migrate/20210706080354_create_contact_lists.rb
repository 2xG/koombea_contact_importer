class CreateContactLists < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')

    create_table :contact_lists do |t|
      t.string :status, null: false, default: 'on_hold'
      t.hstore :mapping, default: {}
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_reference :contacts, :contact_list, foreign_key: true
  end
end
