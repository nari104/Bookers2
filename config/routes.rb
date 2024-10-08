Rails.application.routes.draw do

  root to: "homes#top"
  get "/home/about" => "homes#about", as:"about"

  devise_for :users

  resources :books, only: [:new, :create, :index, :show, :update, :edit, :destroy]
  resources :users, only: [:index, :show, :edit, :update, :create]
end
