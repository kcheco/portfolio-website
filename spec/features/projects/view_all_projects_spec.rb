require 'rails_helper'

feature "Viewing a list of projects" do
  background do
    given_i_have_a_list_of_projects
  end

  scenario "I am only able to see a list of the projects I have completed" do
    when_i_visit_the_projects_page
    then_i_should_see_the_list_of_projects_i_completed
    and_i_should_not_see_the_add_new_button
  end

  scenario "as an admin I am about see I can add new project" do
    given_i_am_an_admin
    and_i_sign_in
    when_i_visit_the_projects_page
    then_i_should_see_the_list_of_projects_i_completed
    and_i_should_see_the_add_new_button
  end

  private
  def given_i_am_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  def and_i_sign_in
    sign_in @user
  end

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

  def and_i_should_not_see_the_add_new_button
    expect(page).to_not have_css("a[href='/admin/projects/new']")
  end

  def and_i_should_see_the_add_new_button
    expect(page).to have_css("a[href='/admin/projects/new']")
  end
end
