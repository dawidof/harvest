Rails.application.routes.draw do
  root 'welcome#index'
  get 'dashboard', to: 'dashboard#index'
  get 'oauth2/callback'
end
