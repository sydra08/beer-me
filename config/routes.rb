Rails.application.routes.draw do

  root to: 'welcome#home'

  # sessions
  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  # omniauth
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/failure', to: 'welcome#home'

  # need to keep this up here otherwise it doesn't work
  resources :users, only: [:new, :create]

  # nested resources
  resources :users, only: [:show] do
    resources :beers
  end

  resources :beers, only: [:index, :show, :new, :create]
  resources :breweries, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :users, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
