Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants do
        resources :items, only: [:index], module: :merchants
      end

      resources :items do
        resources :merchants, only: [:index], module: :items
      end
    end
  end
end
