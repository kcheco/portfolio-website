require 'rails_helper'

feature "Deleting a project" do
  background do
    given_i_have_a_project_i_no_longer_want_to_share_from_my_list
  end

  scenario "as an admin I am able to successfully remove a project I no longer want to share" do
    given_i_am_an_admin
    and_i_am_signed_in
    when_i_visit_the_projects_page
    and_i_click_the_delete_button_for_the_project_i_dont_want_to_share
    then_i_should_see_i_successfully_removed_the_project
    and_i_should_no_longer_see_the_project_i_deleted
  end

  private
  def given_i_am_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  def and_i_am_signed_in
    sign_in @user
  end

  def given_i_have_a_project_i_no_longer_want_to_share_from_my_list
    @project_list = FactoryBot.create_list(:project, 5, :with_cover)
    @project = @project_list.first
  end

  def when_i_visit_the_projects_page
    visit '/projects'
  end

  def and_i_click_the_delete_button_for_the_project_i_dont_want_to_share
    accept_confirm do
      find(:css, "a[href='/admin/projects/#{@project.id}']").click
    end
  end

  def then_i_should_see_i_successfully_removed_the_project
    expect(page).to have_content("Project was successfully deleted.")
  end

  def and_i_should_no_longer_see_the_project_i_deleted
    expect(page).to_not have_content("#{@project.name}")
  end
end
