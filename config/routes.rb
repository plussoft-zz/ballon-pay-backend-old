require 'api_constraints'

Rails.application.routes.draw do
  use_doorkeeper
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      get 'home', to: 'home#index'
    end

    # scope module: :v2, constraints: ApiConstraints.new(version: 2, default: true) do
    #   resources :products
    # end
  end
end
