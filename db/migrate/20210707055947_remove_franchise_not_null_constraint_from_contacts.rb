class RemoveFranchiseNotNullConstraintFromContacts < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:contacts, :franchise, true)
    change_column_null(:contacts, :dob, true)
  end
end
