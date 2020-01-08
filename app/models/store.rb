class Store < ApplicationRecord
  before_save :define_number
  
  belongs_to :user
  has_many :accounts

  private 

  def define_number 
    if self.number.present?
      return
    end

    self.number = self.user.stores.any? ? self.user.stores.maximum('number') + 1 : 1
  end
end
