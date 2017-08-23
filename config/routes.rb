Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post "/", to: "questions#index"
  get "/categories/:category", to: "questions#category"


  namespace :api do
    namespace :v1 do
      resources :users

      post '/login', to: 'sessions#create'
      post '/signup', to: 'users#create'
      get '/me', to: 'users#me'
    end
  end
end
