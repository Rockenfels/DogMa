Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :dogs
  resources :owners
  resources :shelters
  resources :owner_sessions, only: [:new, :create, :destroy]
  resources :shelter_sessions, only: [:new, :create, :destroy]
  resource :adoptions, only: [:create]
  
  get '/adopt', to: 'adoptions#new'
  get '/abandon', to: 'adoptions#new'
  get '/move', to: 'adoptions#move'


  get '/auth/facebook/callback' => 'sessions#createOwner'
  root to: 'static#index'
end
