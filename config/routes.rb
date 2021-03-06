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

  resources :beers, only: [:index, :show]
  resources :breweries, only: [:index, :show, :new, :create]
  resources :categories, only: [:index, :show]
  
  # nested resources
  resources :users, only: [:show] do
    resources :user_beers, only: [:index, :show, :update, :destroy]
  end

  resources :users, only: [:show] do
    resources :beers, only: [:new, :create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
