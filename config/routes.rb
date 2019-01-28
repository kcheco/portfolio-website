Rails.application.routes.draw do

  devise_for :users, skip: [:sessions], controllers: { registrations: 'registrations' }
  as :user do
  #  get     'signup',       to: 'devise/registrations#new', as: 'new_user_registration_path'
  #  post    'signup',       to: 'devise/registrations#create', as: ''
   get     'admin/login',   to: 'devise/sessions#new',      as: 'new_user_session'
   post    'admin/login',   to: 'devise/sessions#create',   as: 'user_session'
   delete  'admin/logout',  to: 'devise/sessions#destroy',  as: 'destroy_user_session'
  end

  resources :books, only: [ :new, :create, :show, :edit, :update, :index, :destroy ]
  resources :watched_videos, only: [ :new, :create, :edit, :update, :index, :destroy ]
  resources :projects, only: [ :index, :new, :create, :edit, :update, :destroy ]

  root to: 'pages#home'
end
