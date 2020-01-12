class Api::V1::ProposalController < Api::V1::ApiController
  before_action :set_initial_data, only: [:create]

  def create
    @account_list = []
    @account_types.each do |account_type|
      @account = @store.accounts.new({ account_type: account_type })

      people_params['people'].each do |item|
        @account.people.build({
          kind: item['kind'], 
          person: define_peson(item['person']), 
          password: Faker::Number.number(digits: 4).to_s.rjust(4, '0')
        })
      end

      @account_list << @account
    end

    @account_list.each do |account|
      account.people.each do |person|
        person.cards.build(brand_card: @brand_card)
      end
    end

    if @store.save
      render json: @account_list, status: :created
    else
      render json: @store.errors, status: :unprocessable_entity
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
  def set_initial_data
    @store = current_user.stores.first
    @account_types = people_params['account_type'] === "multiple" ? current_user.account_types.default() : current_user.account_types.default().where(kind: people_params['account_type'])
    @brand_card = BrandCard.default.first
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
