class Account < ApplicationRecord
  before_save :define_number

  belongs_to :store
  belongs_to :account_type
  has_many :entries

  private 

  def define_number 
    if self.number.present?
      return
    end

    self.number = self.store.accounts.any? ? self.store.accounts.maximum('number') + 1 : 1
  end
end
