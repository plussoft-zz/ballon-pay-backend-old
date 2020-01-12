# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :access_grants,
       class_name: 'Doorkeeper::AccessGrant',
       foreign_key: :resource_owner_id,
       dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
		class_name: 'Doorkeeper::AccessToken',
		foreign_key: :resource_owner_id,
		dependent: :delete_all # or :destroy if you need callbacks
		
	before_save :define_store, unless: Proc.new { self.stores.any? }
	before_save :define_account_type, unless: Proc.new { self.account_types.any? }
	before_save :define_brand_card, unless: Proc.new { BrandCard.any? }

	has_many :people
	has_many :stores
	has_many :account_types
	has_many :accounts, through: :stores
	has_many :applications, class_name: 'Doorkeeper::Application', as: :owner
	
  private

  def define_store
    self.stores.new(number: 1, name: 'Default Store', default: true)
  end

  def define_account_type
    self.account_types.new(kind: :credit, name: 'Credit Account', default: true)
    self.account_types.new(kind: :current, name: 'Current Account', default: true)
  end

  def define_brand_card
    BrandCard.create(number: 600001, name: 'Ballon-Pay Card', status: :activated, default: true)
  end
end
