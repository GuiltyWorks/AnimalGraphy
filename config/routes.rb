Rails.application.routes.draw do
  root "home#top"

  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  post "login" => "users#login"
  post "logout" => "users#logout"

  get "login" => "users#login_form"
  get "signup" => "users#new"
  get "users/index" => "users#index"
  get "users/:id/edit" => "users#edit"
  get "users/:id/likes" => "users#likes"
  get "users/:id" => "users#show"

  post "users/create" => "users#create"
  post "users/:id/update" => "users#update"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/tags/:tag" => "posts#tags"
  get "posts/:id/edit" => "posts#edit"
  get "posts/:id" => "posts#show"

  post "posts/create" => "posts#create"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  get "/" => "home#top"
  get "/about" => "home#about"
end
