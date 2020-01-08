class Person < ApplicationRecord
  include Filterable

  before_save :unmask_document_number

  belongs_to :user

  scope :full_name, -> (full_name) { where("lower(full_name) like ?", "%#{full_name.downcase}%")}
  scope :user_id, -> (user_id) { where("user_id = ?", user_id)}
  scope :document_number, -> (document_number) { where("document_number = ?", document_number)}  

  validates :document_number, uniqueness: { scope: :user_id,
    message: "should happen once per user" }

  private

  def unmask_document_number
    self.document_number.gsub!(/[^0-9A-Za-z]/, '')
  end
end
