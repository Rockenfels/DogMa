Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :dogs, :shelters
  resources :owners, except: [:index]

  get '/owners/login' to: 'owners#new'
  get '/shelters/login' to: 'shelters#new'
  root to: 'static#index'
end

#ADD NAMESPACING FOR SHELTER_DOGS ROUTES
#ADD LOGIN & LOGOUT ROUTES FOR SHELTERS AND OWNERS
#ADD INDEX PATH FOR BOTH LOGIN OPTIONS ^
