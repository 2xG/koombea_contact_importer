require 'csv'
CSV.open("file.csv", "w") do |csv|
  10000.times do
    csv << [
      [Faker::Name.name, ''].sample,
      [Faker::Date.birthday(min_age: 15, max_age: 65), ''].sample,
      [Faker::PhoneNumber.phone_number,
       Faker::Base.numerify('(+##) ### ### ## ##'),
       Faker::Base.numerify('(+##) ###-###-##-##')].sample,
      [Faker::Address.full_address, ''].sample,
      Faker::Finance.credit_card,
      Faker::Internet.email
    ]
  end
end
