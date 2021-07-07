require 'csv'

class ContactListWorker
  include Sidekiq::Worker

  def perform(id)
    contact_list = ContactList.find id
    contact_list.processing!
    contact_list.csv.open do |csv_file|
      CSV.foreach(csv_file, headers: contact_list.header_row?) do |row|
        contact = contact_list.contacts.build contact_list.row2contact_attributes(row)
        unless contact.save
          contact.imported = false
          contact.error_list = contact.errors.full_messages.join("\n")
          contact.errors.clear
          contact.save
        end
      end
    end

    if contact_list.contacts.imported.count.positive?
      finished!
    else
      failed!
    end
  end
end
