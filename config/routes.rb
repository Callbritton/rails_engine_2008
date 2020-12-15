Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      namespace :items do
        get '/:id/merchants', to: 'merchants#show'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      resources :items
      resources :merchants
    end
  end
end
