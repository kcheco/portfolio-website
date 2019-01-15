require 'rails_helper'

feature "Viewing a list of projects" do
  scenario "I am able to see a list of the projects I have completed" do
    given_i_have_a_list_of_projects
    when_i_visit_the_projects_page
    then_i_should_see_the_list_of_projects_i_completed
  end

  private
  def given_i_have_a_list_of_projects
    @projects_list = FactoryBot.create_list(:project, 5, :with_cover)
  end

  def when_i_visit_the_projects_page
    visit '/projects'
  end

  def then_i_should_see_the_list_of_projects_i_completed
    @projects_list.each do |project|
      expect(page).to have_content("#{project.name}")
    end
  end
end
