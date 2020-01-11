class Api::V1::HomeController < ApplicationController
  before_action only: [:index] do
    doorkeeper_authorize! 
  end

  def index
    render json: {message: 'hello world'}
  end
end
