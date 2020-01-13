require 'person_utils'

class Person < ApplicationRecord
  include PersonUtils
  include Filterable

  before_save :unmask_document_number

  belongs_to :user
  has_many :addresses
  has_many :contacts
  has_many :account_people
  has_many :accounts, through: :account_people
  has_many :cards, through: :account_people

  scope :full_name, -> (full_name) { where("lower(full_name) like ?", "%#{full_name.downcase}%")}
  scope :user_id, -> (user_id) { where("user_id = ?", user_id)}
  scope :document_number, -> (document_number) { where("document_number = ?",  document_number.gsub(/[^0-9A-Za-z]/, ''))}  

  validates :document_number, uniqueness: { scope: :user_id,
    message: "should happen once per user" }

  private

  def unmask_document_number
    self.document_number = remove_mask(self.document_number)
  end
end
