class PagesController < ApplicationController
  def home
    @projects = Project.latest
  end
end
