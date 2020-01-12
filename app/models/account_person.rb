require 'faker'

class AccountPerson < ApplicationRecord
  # before_save :define_password, unless: Proc.new { self.password.present? }
  
  has_secure_password
  has_secure_password :recovery_password, validations: false

  belongs_to :account
  belongs_to :person
  has_many :cards
  
  enum kind: [:holder, :dependent]

  # validates password, presence: true, length: {minimum: 4}

  # private

  # def define_password
  #   self.password = Faker::Number.number(digits: 4)
  # end
end
