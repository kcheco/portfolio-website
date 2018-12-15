Rails.application.routes.draw do
  get 'books/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :books, only: [ :new, :create, :show ]
end
