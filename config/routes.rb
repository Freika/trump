Rails.application.routes.draw do
  resources :realms
  root to: 'realms#index'
end
