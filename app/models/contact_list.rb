require 'csv'

class ContactList < ApplicationRecord
  STATUSES = %i[on_hold processing failed finished].freeze

  enum status: STATUSES.zip(STATUSES.map(&:to_s)).to_h

  belongs_to :user
  has_many :contacts

  has_one_attached :csv

  validates :csv, presence: true, content_type: [:csv], on: :create
  with_options on: :update, if: :on_hold? do |updated|
    updated.validate :complete_mapping
    updated.validate :mapping_without_duplicates
  end

  before_save :format_mapping, if: :on_hold?
  after_update :create_contacts, if: :on_hold?

  # Returns first n rows of a file as array
  #
  # @param [Integer] row_count
  # @return [Array]
  def csv_preview(row_count = 5)
    csv.open do |csv_file|
      CSV.foreach(csv_file).first(row_count).to_a
    end
  end

  # Tells if the file was mapped
  # @return [Boolean]
  def mapped?
    mapping.any?
  end

  def create_contacts
    processing!
    csv.open do |csv_file|
      CSV.foreach(csv_file, headers: header_row?) do |row|
        contact = contacts.build row2contact_attributes(row)
        unless contact.save
          contact.imported = false
          contact.error_list = contact.errors.full_messages.join("\n")
          contact.errors.clear
          contact.save
        end
      end
    end

    if contacts.imported.count.positive?
      finished!
    else
      failed!
    end
  end

  private

  def complete_mapping
    errors.add(:mapping, :incomplete) unless (Contact.attribute_map.to_h.values - mapping.values).count.zero?
  end

  def mapping_without_duplicates
    # @type Hash
    attr_counter = mapping.values.group_by(&:to_s).map { |a| [a[0], a[1].count] }.to_h.except('')
    duped_mappings = attr_counter.select { |_, count| count > 1 }
    errors.add(:mapping, :duplicates, columns: duped_mappings.keys.join('", "')) unless duped_mappings.count.zero?
  end

  def format_mapping
    self[:mapping] = mapping.invert.except('')
  end

  def row2contact_attributes(row)
    attr_hash = { user: user, imported: true }
    Contact.attribute_map.to_h.values.map(&:to_s).each do |attr|
      attr_hash[attr] = row[mapping[attr].to_i].to_s.strip
    end
    attr_hash
  end
end
