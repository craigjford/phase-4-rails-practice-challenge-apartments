Rails.application.routes.draw do
  
  resources :tenants, only: [:create, :index, :show, :update, :destroy] do 
    resources :leases, only: [:create, :destroy]
  end

  resources :apartments, only: [:create, :index, :show, :update, :destroy] do
    resources :leases, only: [:create, :destroy]
  end

  # resources :leases, only: [:index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
