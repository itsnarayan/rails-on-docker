Rails.application.routes.draw do
  root to: 'companies#index'

  resources :companies do
    collection do
      get :all
    end
  end

  resources :users do
    collection do
      get :agreements
      post :update_policy
    end
  end

  resources :performance, only: [] do
    collection do
      get :mem
      get :cpu
    end
  end
end
