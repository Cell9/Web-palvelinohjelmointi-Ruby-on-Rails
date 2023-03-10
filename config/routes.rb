Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries


  root 'breweries#index'

  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
 

  post 'places', to: 'places#search'

  delete 'signout', to: 'sessions#destroy'

  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]
end
