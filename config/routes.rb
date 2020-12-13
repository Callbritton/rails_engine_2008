Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      resources :items
      namespace :items do
        get '/:id/merchants', to: 'merchants#show'
      end

      resources :merchants
      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end
    end
  end
end
