Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items
  # get 'items/new/:id' to: 'items#tax'
end