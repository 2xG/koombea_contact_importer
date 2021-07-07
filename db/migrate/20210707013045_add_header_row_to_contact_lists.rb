class AddHeaderRowToContactLists < ActiveRecord::Migration[6.1]
  def change
    add_column :contact_lists, :header_row, :boolean, default: false
  end
end
