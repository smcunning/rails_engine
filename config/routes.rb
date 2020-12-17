Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/most_revenue', to: 'revenue#most_revenue'
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      namespace :items do
        get '/find', to: 'search#show'
      end

      resources :merchants do
        resources :items, only: [:index], module: :merchants
      end

      resources :items do
        resources :merchants, only: [:index], module: :items
      end
    end
  end
end
