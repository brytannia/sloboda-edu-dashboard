Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }

  get 'users/search' => 'users#search'

  resources :users
  root to: 'events#index'
end
