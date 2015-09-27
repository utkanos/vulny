Rails.application.routes.draw do
  resources :users, only: [:index]
  resources :sessions, only: [:new, :create, :destroy]

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'get'
  match '/register', to: 'sessions#register',     via: 'get'
  match '/forgot', to: 'sessions#forgot',     via: 'get'

  root to: 'sessions#new'
end
