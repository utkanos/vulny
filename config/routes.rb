Rails.application.routes.draw do
  get 'static_pages/admin'

  get 'static_pages/console'

  get 'static_pages/configure'

  get 'static_pages/maint'

  resources :users, only: [:index]
  resources :sessions, only: [:new, :create, :destroy, :register, :forgot]

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'get'
  match '/register', to: 'sessions#register',     via: 'get'
  match '/forgot', to: 'sessions#forgot',     via: 'get'
  match '/admin', to: 'static_pages#admin',     via: 'get'
  match '/console', to: 'static_pages#console',     via: 'get'
  match '/maint', to: 'static_pages#maint',     via: 'get'
  match '/configure', to: 'static_pages#configure',     via: 'get'

  root to: 'sessions#new'
end
