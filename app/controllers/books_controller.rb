class BooksController < ApplicationController
  # calls index view and displays a list of all books
  # that have been recorded as read
  def index
    @books = Book.all
  end
end
