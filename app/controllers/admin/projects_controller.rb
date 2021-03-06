module Admin
  class ProjectsController < ApplicationController
    before_action :authenticate_user!, only: [ :index, :new, :edit, :destroy ]
    before_action :set_project, only: [ :edit, :update, :destroy ]
    layout "admin"

    # calls view to display list of projects
    def index
      @projects = Project.all
      render template: "projects/index"
    end

    # calls view that allows user to add a new projects to list
    # of completed projects
    def new
      @project = Project.new
    end

    # ingest valid parameters and adds a new project to list
    def create
      @project = Project.new(project_params)

      respond_to do |format|
        if @project.save
          format.html { redirect_to edit_admin_project_path(@project), 
                        notice: "Project was successfully added." }
        else
          format.html { render :new }
        end
      end
    end

    # calls view that allows user to apply view/changes to a specific
    # project
    def edit
    end

    # ingests valid parameters when apply changes to a specific project
    def update
      respond_to do |format|
        if @project.update(project_params)
          format.html { redirect_to edit_admin_project_path(@project), notice: "Project was successfully updated." }
        else
          format.html { render :edit }
        end
      end
    end

    # removes the specific project form request
    def destroy
      @project.destroy

      respond_to do |format|
        format.html { redirect_to admin_projects_path, notice: "Project was successfully deleted." }
      end
    end

    private
    # identifies a specific project based on id param in request
    def set_project
      @project = Project.find(params[:id])
    end

    # specifies valid parameters that may be ingested by the project resource
    def project_params
      params.require(:project).permit(:name,
                                      :date_completed,
                                      :link,
                                      image_attributes: [
                                        :id,
                                        :source,
                                        :_destroy
                                      ])
    end
  end
end