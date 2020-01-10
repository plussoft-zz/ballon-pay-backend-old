class CreditProposalController < ApplicationController
  before_action :authenticate_user!
  before_action :set_credit_proposal, only: [:create]

  def create
    @account = current_user.accounts.new({ store: @store, account_type: @account_type })
    
    people_params['people'].each do |item|
      @account.people.build({kind: item['kind'], person: define_peson(item['person'])})
    end

    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  private 

  def define_peson(person)
    current_user.people.document_number(person['document_number']).first || create_person(person)
  end

  def create_person(person)
    new_person = current_user.people.build(person.slice('full_name', 'document_number'))

    person['addresses'].each do |address|
      new_person.addresses.build(address)
    end

    person['contacts'].each do |contact|
      new_person.contacts.build(contact)
    end

    return new_person
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_credit_proposal
    @store = current_user.stores.first
    @account_type = current_user.account_types.first
  end

  # Only allow a trusted parameter "white list" through.
  def people_params
    params.permit(
      :account_type, 
      people: [
        :kind, 
        person: [
          :id, 
          :full_name, 
          :document_number, 
          addresses: [
            :id,
            :kind, 
            :street, 
            :number, 
            :complement, 
            :district, 
            :city, 
            :country, 
            :zip_code
          ], 
          contacts: [
            :id,
            :kind, 
            :complement, 
            :text
          ]
        ]
      ]
    )
  end
end
