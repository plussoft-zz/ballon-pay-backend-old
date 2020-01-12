class BrandCard < ApplicationRecord
  enum status: [:disabled, :activated]
  has_many :cards

  scope :default, -> { where(default: true)} 
end
