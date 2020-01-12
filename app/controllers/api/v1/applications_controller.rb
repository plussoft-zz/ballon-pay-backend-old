class Api::V1::ApplicationsController < Api::V1::ApiController
  before_action :set_application, only: [:show, :update, :destroy]

  # GET /applications
  def index
    @applications = current_user.applications

    render json: @applications
  end

  # GET /applications/1
  def show
    render json: @application
  end

  # POST /applications
  def create
    @application = Doorkeeper::Application.create(application_params.merge(owner: current_user))

    if @application
      render json: @application, status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique => e
    render json: {status: :error, error: e.message}, status: :unprocessable_entity
  end

  # PATCH/PUT /applications/1
  def update
    if @application.update(application_params)
      render json: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1
  def destroy
    @application.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = current_user.applications.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def application_params
      params.require(:application).permit(:name, :redirect_uri, :scopes)
    end
end
