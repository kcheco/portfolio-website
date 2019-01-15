require 'rails_helper'

feature "Update a project" do
  background do
    given_i_have_a_project_i_want_to_update
  end

  scenario "I am able to successfully apply changes" do
    when_i_see_the_project_i_want_to_edit
    and_i_change_the_project_name
    and_i_change_the_link
    and_i_click_the_update_button
    then_i_should_see_i_successfully_made_changes
  end

  scenario "I am able to successfully change the cover of the project" do
    when_i_see_the_project_i_want_to_edit
    and_i_change_the_cover
    and_i_click_the_update_button
    then_i_should_see_i_successfully_made_changes
    and_i_should_see_the_updated_cover
  end

  private
  def given_i_have_a_project_i_want_to_update
    @project = FactoryBot.create(:project, :with_cover)
  end

  def when_i_see_the_project_i_want_to_edit
    visit "/projects"
    page.has_content?("#{@project.name}")
    find(:css, "a[href='/projects/#{@project.id}/edit']").click
  end

  def and_i_change_the_project_name
    fill_in "Name", :with => "BDD Tutorial"
  end

  def and_i_change_the_link
    fill_in "Link", :with => "example.com"
  end

  def and_i_change_the_cover
    fill_in "Cover", :with => "http://exampleproject.com/updated_cover.png"
  end

  def and_i_click_the_update_button
    click_button "Apply Changes"
  end

  def then_i_should_see_i_successfully_made_changes
    expect(page).to have_content("Project was successfully updated.")
  end

  def and_i_should_see_the_updated_cover
    expect(page).to have_css("img[src='http://exampleproject.com/updated_cover.png']")
  end
end
