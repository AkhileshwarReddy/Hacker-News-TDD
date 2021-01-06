Rails.application.routes.draw do
  
  devise_for :users

  root to: "submissions#newest"

  get "/user", to: "users#user"
  patch "/user", to: "users#update"

  get "/submit", to: "submissions#new"
  post "/submissions/create", to: "submissions#create"
  get "/newest", to: "submissions#newest"
  get "/item", to: "submissions#display_submission"
  get "/hide", to: "submissions#hide"
  get "/hidden", to: "submissions#hidden"
  get "/ask", to: "submissions#askhn"
  get "/show", to: "submissions#showhn"
  get "/shownew", to: "submissions#shownew"
  get "/submitted", to: "submissions#submitted"
  get "/past", to: "submissions#past"

  post "/comment/create", to: "comments#create"
  get "/newcomments", to: "comments#new_comments"
  get "/comment", to: "comments#show"
  post "/reply", to: "comments#reply"
  get "/threads", to: "comments#threads"

  get "/fave", to: "favorites#index"
  get "/favorites", to: "favorites#favorites"

  get "/vote", to: "votes#vote"
  get "/upvoted", to: "votes#upvoted"

  get "/search", to: "search#search"
end
