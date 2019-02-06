module Admin
  class SkillsController < ApplicationController
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

    private
    # specifies valid parameters that may be ingested by
    # the skills resource
    def skill_params
      params.require(:skill).permit(:name)
    end
  end
end