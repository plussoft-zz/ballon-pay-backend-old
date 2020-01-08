class AccountType < ApplicationRecord
  belongs_to :user
  enum kind: [:current, :credit]
end
