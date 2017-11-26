Rails.application.routes.draw do

  root to: 'welcome#home'

  # sessions
  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'


  resources :beers, only: [:index, :show, :new, :create]
  resources :breweries, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
