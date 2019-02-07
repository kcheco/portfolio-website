require 'rails_helper'

feature 'Add a skill' do
  background do
    given_i_am_an_admin
    and_i_am_signed_in
  end

  scenario 'with name is successful' do
    when_i_visit_the_admin_skills_page
    and_i_click_add_new_skill
    and_i_set_the_skill_i_want_to_add
    and_i_click_the_create_button
    then_i_should_see_i_succcessfully_added_the_skill
  end

  scenario 'with no name displays errors' do
    when_i_visit_the_admin_skills_page
    and_i_click_add_new_skill
    and_i_click_the_create_button
    then_i_should_see_an_error
  end

  private
  def given_i_am_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  def and_i_am_signed_in
    sign_in @user
  end

  def when_i_visit_the_admin_skills_page
    visit '/admin/skills'
  end

  def and_i_click_add_new_skill
    click_link "Add New Skill"
  end

  def and_i_set_the_skill_i_want_to_add
    fill_in "Name", :with => "#{Faker::ProgrammingLanguage.name}"
  end

  def and_i_click_the_create_button
    click_button "Add Skill"
  end

  def then_i_should_see_i_succcessfully_added_the_skill
    expect(page).to have_content("Skill was successfully added.")
  end

  def then_i_should_see_an_error
    expect(page).to have_content("There was an error.")
  end
end