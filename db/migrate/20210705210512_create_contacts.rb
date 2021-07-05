class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.date :dob, null: false
      t.string :phone, null: false
      t.string :address, null: false
      t.string :credit_card, null: false
      t.string :franchise, null: false
      t.string :email, null: false
      t.boolean :imported, null: false

      t.references :user, foreign_key: true
      t.timestamps
    end

    add_index :contacts, %i[user_id email], unique: true
  end
end
