class AddEncryptedCreditCardToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :encrypted_credit_card, :string
  end
end
