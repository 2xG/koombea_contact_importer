class Contact < ApplicationRecord
  ALLOWED_DATE_FORMATS = %w[%Y%m%d %F].freeze
  ALLOWED_FRANCHISES = %i[amex discover jcb mastercard visa diners].freeze

  enum franchise: ALLOWED_FRANCHISES.zip(ALLOWED_FRANCHISES.map(&:to_s)).to_h

  before_validation :detect_credit_card_franchise

  with_options(presence: true) do |present|
    present.validates :name, format: { with: /\A[[:alnum:] -]+\z/ }
    present.validates :dob
    present.validates :phone, format: { with: /\A\(\+\d{2}\)[ -]\d{3}[ -]\d{3}[ -]\d{2}[ -]\d{2}\z/ }
    present.validates :address
    present.validates :credit_card, credit_card_number: { brands: ALLOWED_FRANCHISES }
    present.validates :franchise
    present.validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  end
  validate :dob_format

  scope :imported, -> { where(imported: true) }
  scope :failed, -> { where(imported: false) }

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
end
