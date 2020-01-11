class Api::V1::HomeController < Api::V1::ApiController
  def index
    render json: {message: 'hello world', user: current_user}
  end
end
