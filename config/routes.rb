Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  resources :scenarios, only: [:index, :show, :destroy] do
    collection do
      get :search
    end
    member do
      get :download
    end
  end
  resources :scenario_imports, only: [:new, :create]
  resources :agents, only: [:index] do
    collection do
      get :search
    end
  end
  resources :agent_gems, only: [:index]
  resources :documentation, only: [:index, :show]

  post 'webhook/import_agents', 'Webhook#import_agents'

  root to: 'welcome#index'
end
