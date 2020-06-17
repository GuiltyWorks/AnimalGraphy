Rails.application.routes.draw do
  root "posts#index"

  devise_scope :user do
    post "users/sign_in_with_guest" => "users/sessions#new_guest"
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "omniauth_callbacks",
  }

  get "/zoo" => "zoo#index"

  get "/news/:key" => "news#index"

  resources :replies, only: [ :edit, :create, :update, :destroy ]
  # get "replies/:id/edit" => "replies#edit"
  # post "replies/:post_id/create" => "replies#create"
  # post "replies/:id/update" => "replies#update"
  # post "replies/:id/destroy" => "replies#destroy"

  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  post "login" => "users#login"
  post "logout" => "users#logout"

  get "users/index" => "users#index"
  get "users/:id/likes" => "users#likes"
  get "users/:id" => "users#show"

  # get "posts/index" => "posts#index"
  get "posts/search" => "posts#search"
  get "posts/ranking/:period" => "posts#ranking"
  # get "posts/new" => "posts#new"
  get "posts/tags/:id" => "posts#tags"
  resources :posts
  # get "posts/:id/edit" => "posts#edit"
  # get "posts/:id" => "posts#show"

  # post "posts/create" => "posts#create"
  # post "posts/:id/update" => "posts#update"
  # post "posts/:id/destroy" => "posts#destroy"

  get "/" => "posts#index"
  get "/about" => "home#about"
end
