Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  get 'users/search' => 'users#search'

  resources :users
  root to: 'events#index'
end
