class CreditProposalController < ApplicationController
  before_action :set_user, :set_initial_data, only: [:create]

  def create
    @account_list = []
    @account_types.each do |account_type|
      @account = @store.accounts.new({ account_type: account_type })

      people_params['people'].each do |item|
        @account.people.build({kind: item['kind'], person: define_peson(item['person'])})
      end

      @account_list << @account
    end

    if @store.save
      render json: @account_list, status: :created, location: @account
    else
      render json: @store.accounts.errors, status: :unprocessable_entity
    end
  end

  private 

  def define_peson(person)
    @user.people.document_number(person['document_number']).first || create_person(person)
  end

  def create_person(person)
    new_person = @user.people.build(person.slice('full_name', 'document_number'))

    person['addresses'].each do |address|
      new_person.addresses.build(address)
    end

    person['contacts'].each do |contact|
      new_person.contacts.build(contact)
    end

    return new_person
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_initial_data
    @store = @user.stores.first
    @account_types = people_params['account_type'] === "multiple" ? @user.account_types.default() : @user.account_types.default().where(kind: people_params['account_type'])
  rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
  end

  def set_user
    @user = User.find(request.headers[:client])
  rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
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
