Rails.application.routes.draw do
  root "top_page#home"
  get "/help", to: "top_page#help"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users
end