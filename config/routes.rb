# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  scope path: '', controller: :dashboard do
    get :dashboard, action: :index
    get :account, action: :account
    get :settings, action: :settings
    get 'history/:id', action: :history, as: :history
    post :dashboard, action: :create
    patch :update, action: :update
    patch :save_history, action: :save_history
    get :logout, action: :logout # method: :delete not working without jquery
  end

  get 'oauth2/callback'
end
