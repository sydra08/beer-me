Rails.application.routes.draw do

  resources :beers, only: [:show]
  resources :breweries, only: [:index, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories, only: [:index, :show]
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
