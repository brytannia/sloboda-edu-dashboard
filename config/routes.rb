Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  resources :users
  root to: 'events#index'
end
