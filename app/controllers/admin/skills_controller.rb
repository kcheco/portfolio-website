module Admin
  class SkillsController < ApplicationController
    before_action :authenticate_user!, only: [ :index, :new, :edit, :destroy ]
    before_action :set_skill, only: [ :edit, :update, :destroy ]

    # calls index view and displays a list of skills
    def index
      @skills = Skill.all
    end

    # calls view to be rendered to add a new skill
    def new
      @skill = Skill.new
    end

    # ingests valid parameters and adds a new skill
    def create
      @skill = Skill.new(skill_params)

      respond_to do |format|
        if @skill.save
          format.html { redirect_to admin_skills_path, 
                        notice: 'Skill was successfully added.' }
        else
          format.html { render :new }
        end
      end
    end

    # calls view to be rendered for editing a skill
    def edit
    end

    # ingests valid parameters and applies changes to a specific skill
    def update
      respond_to do |format|
        if @skill.update(skill_params)
          format.html { redirect_to admin_skills_path, 
                        notice: 'Skill was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    # removes a skill from list
    def destroy
      @skill.destroy

      respond_to do |format|
        format.html { redirect_to admin_skills_path, 
                      notice: 'Skill was successfully deleted.' }
      end
    end

    private
    # identifies a specific skill from id parameter in request
    def set_skill
      @skill = Skill.find(params[:id])
    end
    # specifies valid parameters that may be ingested by
    # the skills resource
    def skill_params
      params.require(:skill).permit(:name)
    end
  end
end