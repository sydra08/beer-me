Rails.application.routes.draw do

  root to: 'welcome#home'

  resources :beers, only: [:show, :new, :create]
  resources :breweries, only: [:index, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories, only: [:index, :show]
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
