# frozen_string_literal: true

Rails.application.routes.draw do
  root 'feed#show'

  # Users
  get 'sign_up', to: 'users#new'
  post 'sign_up', to: 'users#create'
  resource :profile, only: %i[show update], controller: 'users'
  namespace :users do
    patch 'change_password', to: 'passwords#update'
    resources :password_resets, only: %i[new create edit update]
  end

  # sessions
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :listings, except: :index
  resources :my_listings, except: :show
end
