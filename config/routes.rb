Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/revenue", to: 'revenue#show'

      namespace :merchants do
        get '/most_revenue', to: 'revenue#most_revenue'
        get '/most_items', to: 'items#most_items'
        get '/:id/revenue', to: 'revenue#revenue'
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :merchants do
        resources :items, only: [:index], module: :merchants
      end

      namespace :items do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :items do
        resources :merchants, only: [:index], module: :items
      end
    end
  end
end
