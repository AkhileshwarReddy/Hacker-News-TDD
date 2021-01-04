Rails.application.routes.draw do
  
  devise_for :users

  get "/user", to: "users#user"
  patch "/user", to: "users#update"
  
end
