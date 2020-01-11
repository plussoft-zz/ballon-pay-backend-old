class Api::V1::ApiController < ApplicationController
  before_action :doorkeeper_authorize!

  def current_user
    user_id = doorkeeper_token.resource_owner_id? ? 
      doorkeeper_token.resource_owner_id : 
      define_user_by_application(doorkeeper_token.application_id)
      
    User.find(user_id) if user_id.present?
  end

  private 

  def define_user_by_application(application_id)
    Doorkeeper::Application.find(application_id).owner_id if application_id.present?
  end
end
