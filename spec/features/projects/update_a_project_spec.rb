require 'rails_helper'

feature "Update a project" do
  scenario "I am able to successfully apply changes" do
    given_i_have_a_project_i_want_to_update
    when_i_visit_the_edit_page
    and_i_change_the_project_name
    and_i_change_the_link
    and_i_click_the_update_button
    then_i_should_see_i_successfully_made_changes
  end

  private
  def given_i_have_a_project_i_want_to_update
    @project = FactoryBot.create(:project)
  end

  def when_i_visit_the_edit_page
    visit "/projects"
    find(:css, "a[href='/projects/#{@project.id}/edit']").click
  end

  def and_i_change_the_project_name
    fill_in "Name", :with => "BDD Tutorial"
  end

  def and_i_change_the_link
    fill_in "Link", :with => "example.com"
  end

  def and_i_click_the_update_button
    click_button "Apply Changes"
  end

  def then_i_should_see_i_successfully_made_changes
    expect(page).to have_content("Project was successfully updated.")
  end
end
