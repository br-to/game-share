Rails.application.routes.draw do
  root "top_page#home"
  get "/help", to: "top_page#help"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: [:new, :create, :show]
  resources :games, only: [:index, :new, :create, :show, :update, :destroy]
  resource :profile, only: [:show, :edit, :update, :destroy]
end
