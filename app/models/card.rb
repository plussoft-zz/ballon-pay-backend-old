require 'person_utils'

class Card < ApplicationRecord
  include PersonUtils

  before_save :define

  belongs_to :brand_card
  belongs_to :account_person
  has_one :account, through: :account_person
  has_one :person, through: :account_person

  private

  def define
    self.printed_name = abrevia(self.account_person.person.full_name) unless self.printed_name.present?
    self.due_date = 3.years.from_now unless self.due_date.present?
    self.verification_code = Faker::Number.number(digits: 3) unless self.verification_code.present?
    self.number = self.brand_card.cards.any? ? self.brand_card.cards.maximum('number') + 1 : 1 unless self.number.present?
    self.full_number = generate_card_number(self.number) unless self.full_number.present?
  end

  def generate_card_number(number)
    brand_number = self.brand_card.number.to_s.rjust(6,'0')
    number = self.number.to_s.rjust(9,'0')
    card_number = "#{brand_number}#{number}"

    self.full_number = "#{card_number}#{Luhn.control_digit(card_number)}"  unless self.full_number.present?
  end
end
