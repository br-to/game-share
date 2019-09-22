Rails.application.routes.draw do
  root "top_page#home"
  get "/help", to: "top_page#help"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: :edit
  resources :users, only: [:new, :create, :show]
  resources :games, shallow: true do
    resources :reviews do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end
  resource :profile, only: [:show, :edit, :update, :destroy]
end
