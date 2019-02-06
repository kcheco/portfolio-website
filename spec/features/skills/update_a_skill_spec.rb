require 'rails_helper'

feature 'Update a skill' do
  background do
    given_i_want_to_apply_changes_to_a_skill
    and_i_am_signed_in_as_an_admin
  end

  scenario 'as an admin allows me to change the name' do
    when_i_click_on_the_skill_i_want_to_edit
    and_i_set_another_skill_name
    and_click_the_update_button
    then_i_should_see_i_succesfully_updated_the_skill
  end

  private
  def given_i_want_to_apply_changes_to_a_skill
    @skill = Skill.create(name: "Javascript")
  end

  def and_i_am_signed_in_as_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
      password: 'testpw123'})
    sign_in @user
  end

  def when_i_click_on_the_skill_i_want_to_edit
    visit '/'
    click_link 'Skills'
    page.has_content?("#{@skill.name}")
    find(:css, "a[href='/admin/skills/#{@skill.id}/edit']").click
  end

  def and_i_set_another_skill_name
    fill_in "Name", :with => "JavaScript"
  end

  def and_click_the_update_button
    click_button "Apply Changes"
  end

  def then_i_should_see_i_succesfully_updated_the_skill
    expect(page).to have_content("Skill was successfully updated.")
  end
end