class AccountType < ApplicationRecord
  belongs_to :user
  enum kind: [:current, :credit]

  scope :default, -> { where(default: true)} 
end
