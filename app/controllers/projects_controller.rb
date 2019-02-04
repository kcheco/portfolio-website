class ProjectsController < ApplicationController
  # calls view to display list of projects
  def index
    @projects = Project.all
  end
end
