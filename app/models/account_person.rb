class AccountPerson < ApplicationRecord
  belongs_to :account
  belongs_to :person
  
  enum kind: [:holder, :dependent]
end
