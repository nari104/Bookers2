Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"

  resources :books, omly: [:new, :create, :index, :show, :destroy]
  resources :users, only: [:show, :edit]
end
