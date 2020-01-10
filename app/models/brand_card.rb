class BrandCard < ApplicationRecord
  belongs_to :user
  enum status: [:disabled, :activated]

  scope :default, -> { where(default: true)} 
end
