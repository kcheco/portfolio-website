require 'rails_helper'

feature 'View all skills' do
  scenario 'shows a list of skills when signed in as admin' do
    given_i_am_signed_in_as_an_admin
    and_i_have_a_list_of_skills
    when_i_visit_the_admin_skills_page
    then_i_should_see_a_list_of_skills_added
  end

  scenario 'provides feedback when there are no skills added' do
    given_i_am_signed_in_as_an_admin
    when_i_visit_the_admin_skills_page
    then_i_should_see_there_are_no_skills_added_yet
  end

  private
  def given_i_am_signed_in_as_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
      password: 'testpw123'})
    sign_in @user
  end

  def and_i_have_a_list_of_skills
    @skills = FactoryBot.create_list(:skill, 5)
  end

  def when_i_visit_the_admin_skills_page
    visit '/'
    click_link "Skills"
  end

  def then_i_should_see_a_list_of_skills_added
    @skills.each do |skill|
      expect(page).to have_content("#{skill.name}")
    end
  end

  def then_i_should_see_there_are_no_skills_added_yet
    expect(page).to have_content("There are no skills added yet.")
  end
end