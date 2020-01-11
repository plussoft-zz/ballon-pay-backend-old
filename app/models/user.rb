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
       
  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner
end
