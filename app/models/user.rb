class User < ApplicationRecord
  before_save :define_store, unless: Proc.new { self.stores.any? }
  before_save :define_account_type, unless: Proc.new { self.account_types.any? }
  before_save :define_brand_card, unless: Proc.new { self.brand_cards.any? }

  has_many :people
  has_many :stores
  has_many :account_types
  has_many :accounts, through: :stores
  has_many :brand_cards

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  private

  def define_store
    self.stores.new(number: 1, name: 'Default Store', default: true)
  end

  def define_account_type
    self.account_types.new(kind: :credit, name: 'Credit Account', default: true)
    self.account_types.new(kind: :current, name: 'Current Account', default: true)
  end

  def define_brand_card
    self.brand_cards.new(number: 1, name: 'Card mark', status: :activated, default: true)
  end
end
