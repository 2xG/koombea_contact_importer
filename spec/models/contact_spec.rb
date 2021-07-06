require 'rails_helper'

RSpec.describe Contact, type: :model do

  let(:contact) do
    Contact.new \
      name: 'Tony Stark',
      email: 'user@example.com',
      dob: Date.today.strftime('%F'),
      phone: '(+57) 320 432 05 09',
      address: '90210, Sesame street, Narnia',
      credit_card: '4111111111111111'
  end

  it { expect(contact).to be_valid }

  it { expect(contact.tap { |c| c.name = 'Tony+Stark' }).not_to be_valid }

  it { expect(contact.tap { |c| c.dob = Date.today.strftime('%Y%m%d') }).to be_valid }
  it { expect(contact.tap { |c| c.dob = Date.today.strftime('%D') }).not_to be_valid }
  it { expect(contact.tap { |c| c.phone = '(+57) 320-432-05-09' }).to be_valid }
  it { expect(contact.tap { |c| c.phone = '+57 320 432-0509' }).not_to be_valid }
  it { expect(contact.tap { |c| c.email = 'user@user@example.com' }).not_to be_valid }
  it { expect(contact.tap { |c| c.address = '' }).not_to be_valid }
  it { expect(contact.tap { |c| c.credit_card = CreditCardValidations::Factory.random(:maestro) }).not_to be_valid }

end
