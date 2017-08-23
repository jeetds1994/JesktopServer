Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post "/", to: "questions#index"
  get "/categories/:category", to: "questions#category"
end
