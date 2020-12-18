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
        get '/most_revenue', to: 'business#most_revenue'
        get '/most_items', to: 'business#most_items'
        get '/:id/revenue', to: 'business#total_revenue'
      end

      get 'revenue', to: 'merchants/business#revenue_across_range'

      resources :items
      resources :merchants
    end
  end
end
