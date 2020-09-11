Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :dogs, :shelters, :owners
  resources :sessions, only: [:new, :create, :destroy]

  get 'owners/login', to: 'sessions#createOwner'
  get 'shelters/login', to: 'sessions#createShelter'
  get 'owners/logout', to: 'sessions#destroyOwner'
  get 'shelters/logout', to: 'sessions#destroyShelter'

  root to: 'static#index'
end

#ADD NAMESPACING FOR SHELTER_DOGS ROUTES
#ADD LOGIN & LOGOUT ROUTES FOR SHELTERS AND OWNERS
#ADD INDEX PATH FOR BOTH LOGIN OPTIONS ^
