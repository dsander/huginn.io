Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  resources :scenarios
  resources :agents, only: [:index] do
    collection do
      get :search
    end
  end

  root to: 'welcome#index'
end
