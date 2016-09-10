Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  resources :scenarios

  root to: 'welcome#index'
end
