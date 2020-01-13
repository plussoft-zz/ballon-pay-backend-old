require 'person_utils'

class Api::V1::CardsController < Api::V1::ApiController
  include PersonUtils
  before_action :set_card, only: [:show, :update, :destroy]

  def index
    @person = Person.includes(:account_people).find_by_document_number(remove_mask(params[:document_number]))
    raise ActiveRecord::RecordNotFound unless @person.present?

    render json: @person.cards
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    # @store = current_user.stores.find(params[:id])
  end
end
