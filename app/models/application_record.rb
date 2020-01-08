class ApplicationRecord < ActiveRecord::Base
  self.implicit_order_column = "created_at"
  self.abstract_class = true

  def self.jwt_revoked?(payload, user)
    # Does something to check whether the JWT token is revoked for given user
  end

  def self.revoke_jwt(payload, user)
    # Does something to revoke the JWT token for given user
  end
end
