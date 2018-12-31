require 'rails_helper'

feature "Deleting a project" do
  scenario "I am able to successfully remove a project I no longer want to share" do
    given_i_have_a_project_i_no_longer_want_to_share_from_my_list
    when_i_click_the_delete_button
    then_i_should_see_i_successfully_removed_the_project
    and_i_should_no_longer_see_the_project
  end

  private
  def given_i_have_a_project_i_no_longer_want_to_share_from_my_list
    @project_list = FactoryBot.create_list(:project, 5)
    @project = @project_list.first
    visit '/projects'
  end

  def when_i_click_the_delete_button
    find(:css, "a[href='/projects/#{@project.id}']").click
  end

  def then_i_should_see_i_successfully_removed_the_project
    expect(page).to have_content("Project was successfully deleted.")
  end

  def and_i_should_no_longer_see_the_project
    expect(page).to_not have_content("#{@project.name}")
  end
end
