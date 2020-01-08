class User < ApplicationRecord
  before_save :define_store, unless: Proc.new { self.stores.any? }
  before_save :define_account_type, unless: Proc.new { self.account_types.any? }

  has_many :people
  has_many :stores
  has_many :account_types
  has_many :accounts, through: :stores

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  private

  def define_store
    self.stores.new(number: 1, name: 'Default Store')
  end

  def define_account_type
    self.account_types.new(kind: :credit, name: 'Credit Account')
  end
end
