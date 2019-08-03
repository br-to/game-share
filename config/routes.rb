Rails.application.routes.draw do
  root "top_page#home"
  get "top_page/help"
end
