class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:index, :create, :show, :update, :destroy]
  before_action :set_entry, only: [:show, :update, :destroy]

  # GET /entries
  def index
    @entries = @account.entries

    render json: @entries
  end

  # GET /entries/1
  def show
    render json: @entry
  end

  # POST /entries
  def create
    @entry = current_user.accounts.find(params[:account_id]).entries.new(entry_params)

    if @entry.save
      render json: @entry, status: :created
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entries/1
  def update
    if @entry.update(entry_params)
      render json: @entry
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /entries/1
  def destroy
    @entry.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = @account.entries.find(params[:id])
    end

    def set_account
      @account = current_user.accounts.find(params[:account_id])
    end

    # Only allow a trusted parameter "white list" through.
    def entry_params
      params.require(:entry).permit(:due_date, :account_id, :number, :description, :amount, :kind)
    end
end
