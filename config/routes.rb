# frozen_string_literal: true

Rails.application.routes.draw do
  root 'feed#show'

  # Register
  get 'sign_up', to: 'users#new'
  post 'sign_up', to: 'users#create'
  # login
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
end
