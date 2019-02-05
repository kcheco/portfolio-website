module Admin
  class SkillsController < ApplicationController
    def index
    end

    def new
      @skill = Skill.new
    end

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
    def skill_params
      params.require(:skill).permit(:name)
    end
  end
end