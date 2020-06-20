Rails.application.routes.draw do
  root "posts#index"

  devise_scope :user do
    post "users/sign_in_with_guest" => "users/sessions#new_guest"
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "omniauth_callbacks",
  }

  get "/" => "posts#index"
  get "/about" => "home#about"

  get "users/index" => "users#index"
  get "users/:id/likes" => "users#likes"
  get "users/:id" => "users#show"

  get "posts/search" => "posts#search"
  get "posts/ranking/:period" => "posts#ranking"
  get "posts/tags/:id" => "posts#tags"
  resources :posts

  resources :likes, only: [ :create, :destroy ]

  resources :replies, only: [ :edit, :create, :update, :destroy ]

  get "/news/:key" => "news#index"

  get "/zoo" => "zoo#index"
end
