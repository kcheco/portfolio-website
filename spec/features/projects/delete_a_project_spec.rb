require 'rails_helper'

feature "Deleting a project" do
  background do
    given_i_have_a_project_i_no_longer_want_to_share_from_my_list
  end

  scenario "I am able to successfully remove a project I no longer want to share" do
    when_i_see_the_project_i_no_longer_want_to_share
    and_i_click_the_delete_button
    then_i_should_see_i_successfully_removed_the_project
    and_i_should_no_longer_see_the_project_i_deleted
  end

  private
  def given_i_have_a_project_i_no_longer_want_to_share_from_my_list
    @project_list = FactoryBot.create_list(:project, 5, :with_cover)
    @project = @project_list.first
  end

  def when_i_see_the_project_i_no_longer_want_to_share
    visit '/projects'
  end

  def and_i_click_the_delete_button
    accept_confirm do
      find(:css, "a[href='/projects/#{@project.id}']").click
    end
  end

  def then_i_should_see_i_successfully_removed_the_project
    expect(page).to have_content("Project was successfully deleted.")
  end

  def and_i_should_no_longer_see_the_project_i_deleted
    expect(page).to_not have_content("#{@project.name}")
  end
end
