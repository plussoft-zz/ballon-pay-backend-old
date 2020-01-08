Rails.application.routes.draw do
  resources :accounts do
    resources :entries
  end
  resources :account_types
  resources :stores
  resources :people
  post "/graphql", to: "graphql#execute"
  devise_for :users, skip: %i[registrations sessions passwords]
  devise_scope :user do
    post '/signup', to: 'registrations#create'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
end
