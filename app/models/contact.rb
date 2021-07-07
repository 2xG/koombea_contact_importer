class Contact < ApplicationRecord
  ALLOWED_DATE_FORMATS = %w[%Y%m%d %F].freeze
  ALLOWED_FRANCHISES = %i[amex discover jcb mastercard visa diners].freeze
  EXCLUDED_ATTRIBUTES = %w[id user_id created_at updated_at contact_list_id franchise imported error_list].freeze

  enum franchise: ALLOWED_FRANCHISES.zip(ALLOWED_FRANCHISES.map(&:to_s)).to_h

  belongs_to :user
  belongs_to :contact_list

  before_validation :detect_credit_card_franchise, if: :imported?

  with_options(presence: true, if: :imported?) do |present|
    present.validates :name, format: { with: /\A[[:alnum:] -]+\z/ }
    present.validates :dob
    present.validates :phone, format: { with: /\A\(\+\d{2}\)[ -]\d{3}[ -]\d{3}[ -]\d{2}[ -]\d{2}\z/ }
    present.validates :address
    present.validates :credit_card, credit_card_number: { brands: ALLOWED_FRANCHISES }
    present.validates :franchise
    present.validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  end
  validate :email_uniqueness, if: :imported?
  validate :dob_format, if: :imported?

  scope :imported, -> { where(imported: true).order(created_at: :desc) }
  scope :failed, -> { where(imported: false).order(created_at: :desc) }

  def self.attribute_map
    (attribute_names - EXCLUDED_ATTRIBUTES)
      .collect { |attr| [human_attribute_name(attr), attr] }
  end

  private

  def dob_format
    date = nil
    ALLOWED_DATE_FORMATS.each do |format|
      date ||= Date.strptime(read_attribute_before_type_cast(:dob), format)
    rescue Date::Error
      next
    end
    errors.add(:dob, 'has unsupported format') if date.nil?
  end

  def detect_credit_card_franchise
    self.franchise = CreditCardValidations::Detector.new(credit_card).brand
  rescue ArgumentError
    errors.add(:franchise, 'unknown or unsupported')
  end

  def email_uniqueness
    errors.add(:email, :exists) if Contact.where(email: email, user_id: user_id, imported: true).count.positive?
  end
end
