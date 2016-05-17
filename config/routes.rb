Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount Crono::Web, at: '/crono'
  resources :realms
  root to: 'realms#index'
end
