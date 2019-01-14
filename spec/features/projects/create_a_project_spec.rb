require 'rails_helper'

feature "Creating a project" do
  scenario "I am able to successfully add a project I've worked on" do
    when_i_want_to_add_a_new_project_to_my_list
    and_i_set_the_name
    and_i_set_the_date_the_project_was_completed
    and_i_set_the_link
    and_i_set_the_cover_of_the_project
    and_i_click_the_create_button
    then_i_should_see_i_successfully_added_the_project
    and_i_should_see_the_cover_of_the_project
  end

  scenario "always needs a cover" do
    when_i_want_to_add_a_new_project_to_my_list
    and_i_set_the_name
    and_i_set_the_date_the_project_was_completed
    and_i_set_the_link
    and_i_click_the_create_button
    then_i_should_receive_an_error_for_not_setting_a_cover
  end

  def when_i_want_to_add_a_new_project_to_my_list
    visit '/projects'
    click_link 'Add New Project'
  end

  def and_i_set_the_name
    fill_in 'Name', :with => "My Portfolio"
  end

  def and_i_set_the_date_the_project_was_completed
    fill_in 'Date Completed', :with => "2019/01/06"
  end

  def and_i_set_the_link
    fill_in 'Link', :with => "#{Faker::Internet.url}"
  end

  def and_i_set_the_cover_of_the_project
    fill_in 'Cover', :with => "https://cdn-images-1.medium.com/max/1000/1*NlqpTTAM8DbGl4paBmjE_g.jpeg"
  end

  def and_i_click_the_create_button
    click_button "Add Project"
  end

  def then_i_should_see_i_successfully_added_the_project
    expect(page).to have_content("Project was successfully added.")
  end

  def and_i_should_see_the_cover_of_the_project
    expect(page).to have_css("img[src='https://cdn-images-1.medium.com/max/1000/1*NlqpTTAM8DbGl4paBmjE_g.jpeg']")
  end

  def then_i_should_receive_an_error_for_not_setting_a_cover
    expect(page).to have_content("The cover of this project was not added.")
  end
end
