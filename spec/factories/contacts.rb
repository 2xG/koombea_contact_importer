FactoryBot.define do
  factory :contact do
    name { "#{Faker::Name.first_name} #{Faker::Name.last_name}".gsub /([^\w -])/, '' }
    email { Faker::Internet.email }
    # random format birthdate within allowed
    [dob_formatted, dob_iso].sample
    address { Faker::Address.full_address }
    # random format phone number within allowed
    [phone_dashed, phone_spaced].sample
    imported { true }
    # random credit card within allowed
    send Contact::ALLOWED_FRANCHISES.sample

    association :user
    association :contact_list

    trait(:dob_iso) { dob { Faker::Date.birthday(min_age: 18, max_age: 100).strftime('%F') } }
    trait(:dob_formatted) { dob { Faker::Date.birthday(min_age: 18, max_age: 100).strftime('%Y%m%d') } }

    trait(:phone_dashed) { phone { Faker::Base.numerify('(+##) ###-###-##-##') } }
    trait(:phone_spaced) { phone { Faker::Base.numerify('(+##) ### ### ## ##') } }

    Contact::ALLOWED_FRANCHISES.each do |franchise|
      trait(franchise) { credit_card { CreditCardValidations::Factory.random franchise } }
    end
  end
end
