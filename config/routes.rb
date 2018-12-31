Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books, only: [ :new, :create, :show, :edit, :update, :index, :destroy ]
  resources :watched_videos, only: [ :new, :create, :edit, :update, :index, :destroy ]
  resources :projects, only: [ :index, :new, :create, :edit, :update ]
end
