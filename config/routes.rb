Rails.application.routes.draw do
  
  resources :tenants, only: [:create, :index, :show, :update, :destroy]
  resources :apartments, only: [:create, :index, :show, :update, :destroy]

  resources :leases, only: [:create] do
    resources :apartments, only: [:destroy]
    resources :tenants, only: [:destroy]
  end

  # resources :tenants, only: [:create, :index, :show, :update, :destroy] do    
  #     resources :leases, only: [:destroy]
  # end  

  # resources :apartments, only: [:create, :index, :show, :update, :destroy] do    
  #   resources :leases, only: [:destroy]
  # end  

  # resources :leases, only: [:create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
