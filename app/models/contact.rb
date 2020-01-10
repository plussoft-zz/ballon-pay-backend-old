class Contact < ApplicationRecord
  belongs_to :person
  enum kind: [:email, :mobile, :phone]
end
