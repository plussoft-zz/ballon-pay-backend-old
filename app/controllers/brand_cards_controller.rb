class BrandCardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_brand_card, only: [:show, :update, :destroy]

  # GET /brand_cards
  def index
    @brand_cards = current_user.brand_cards

    render json: @brand_cards
  end

  # GET /brand_cards/1
  def show
    render json: @brand_card
  end

  # POST /brand_cards
  def create
    @brand_card = current_user.brand_cards.new(brand_card_params)

    if @brand_card.save
      render json: @brand_card, status: :created, location: @brand_card
    else
      render json: @brand_card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /brand_cards/1
  def update
    if @brand_card.update(brand_card_params)
      render json: @brand_card
    else
      render json: @brand_card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /brand_cards/1
  def destroy
    @brand_card.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand_card
      @brand_card = current_user.brand_cards.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def brand_card_params
      params.require(:brand_card).permit(:user_id, :name, :number, :status)
    end
end
