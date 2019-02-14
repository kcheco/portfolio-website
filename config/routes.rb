Rails.application.routes.draw do

  devise_for :users, skip: [:sessions], controllers: { registrations: 'registrations' }
  as :user do
  #  get     'signup',       to: 'devise/registrations#new', as: 'new_user_registration_path'
  #  post    'signup',       to: 'devise/registrations#create', as: ''
   get     'admin/login',   to: 'devise/sessions#new',      as: 'new_user_session'
   post    'admin/login',   to: 'devise/sessions#create',   as: 'user_session'
   delete  'admin/logout',  to: 'devise/sessions#destroy',  as: 'destroy_user_session'
  end

  namespace 'admin' do
    resources :books, only: [ :new, :create, :edit, :update, :index, :destroy ]
    resources :watched_videos, only: [ :new, :create, :edit, :update, :index, :destroy ]
    resources :projects, only: [ :index, :new, :create, :edit, :update, :destroy ]
    resources :skills, only: [ :index, :new, :create, :edit, :update, :destroy ] do
      put :sort, on: :collection
    end
  end

  resources :books, only: [ :index ]
  resources :watched_videos, only: [ :index ]
  resources :projects, only: [ :index ]

  match '/404',   to: 'errors#not_found',     via: :all
  match '/500',   to: 'errors#server_error',  via: :all
  match '*path',  to: 'errors#not_found',     via: :all

  root to: 'pages#home'
end
