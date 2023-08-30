Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  namespace :api do 
    namespace :v0 do
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index]
      end

      resources :vendors

      resources :market_vendors
    end
  end
  delete '/api/v0/market_vendors', to: 'api/v0/market_vendors#destroy'
end