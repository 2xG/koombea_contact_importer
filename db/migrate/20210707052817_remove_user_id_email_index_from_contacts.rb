class RemoveUserIdEmailIndexFromContacts < ActiveRecord::Migration[6.1]
  def change
    remove_index :contacts, %i[user_id email], unique: true
  end
end
