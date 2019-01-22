class PagesController < ApplicationController
  def home
    @projects = Project.latest
    @books = Book.last_read
  end
end
