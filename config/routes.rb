Rails.application.routes.draw do

  devise_for :users

  resources :books, only: [ :new, :create, :show, :edit, :update, :index, :destroy ]
  resources :watched_videos, only: [ :new, :create, :edit, :update, :index, :destroy ]
  resources :projects, only: [ :index, :new, :create, :edit, :update, :destroy ]

  root to: 'pages#home'
end
