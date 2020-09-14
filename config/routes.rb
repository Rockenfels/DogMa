Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :dogs, :shelters, :owners
  resources :sessions, only: [:new, :create, :destroy]
  resource :adoptions, only: [:new, :create]

  get 'owners/login', to: 'sessions#createOwner'
  get 'shelters/login', to: 'sessions#createShelter'
  get 'owners/logout', to: 'sessions#destroyOwner'
  get 'shelters/logout', to: 'sessions#destroyShelter'
  get 'adopt', to: 'adoptions#new'
  get 'abandon', to: 'adoptions#new'
  get 'move', to: 'adoptions#move'
  root to: 'static#index'
end
