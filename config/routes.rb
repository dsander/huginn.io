Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  resources :scenarios
  resources :agents, only: [:index, :show]

  root to: 'welcome#index'
end
