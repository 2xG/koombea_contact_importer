require 'spec_helper'

RSpec.describe Contact, type: :model do

  context 'with correct data' do
    FactoryBot.factories[:contact].defined_traits.map(&:name).map(&:to_sym).each do |trait|
      it "with trait #{trait}" do
        expect(build(:contact, trait)).to be_valid
      end
    end
  end

  context 'with incorrect data' do
    subject(:contact) { build(:contact) }

    context 'is not valid' do
      it { expect(contact.tap { |c| c.name = 'Tony+Stark' }).not_to be_valid }
      it { expect(contact.tap { |c| c.phone = '+57 320 432-0509' }).not_to be_valid }
      it { expect(contact.tap { |c| c.email = 'user@user@example.com' }).not_to be_valid }
      it { expect(contact.tap { |c| c.address = '' }).not_to be_valid }
      it { expect(contact.tap { |c| c.credit_card = CreditCardValidations::Factory.random(:maestro) }).not_to be_valid }
    end
  end
end
