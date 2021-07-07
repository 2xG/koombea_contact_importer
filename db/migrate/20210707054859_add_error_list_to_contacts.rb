class AddErrorListToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :error_list, :text
  end
end
