class Contact < ApplicationRecord
  enum franchise: { american_express: 0, discover: 1, jcb: 2, mastercard: 3, visa: 4, diners_club: 5 }
end
