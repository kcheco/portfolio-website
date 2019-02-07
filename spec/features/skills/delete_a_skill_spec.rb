require 'rails_helper'

feature 'Delete a skill' do
  background do
    given_i_am_signed_in_as_an_admin
    and_i_have_a_list_of_skills
  end

  scenario 'as an admin allows me to successfully remove the skill' do
    when_i_visit_the_skills_page
    and_click_to_remove_a_skill
    then_i_should_see_skill_was_successfully_deleted
  end

  def given_i_am_signed_in_as_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
      password: 'testpw123'})
    sign_in @user
  end

  def and_i_have_a_list_of_skills
    @skills = FactoryBot.create_list(:skill, 5)
  end

  def when_i_visit_the_skills_page
    visit '/'
    click_link "Skills"
  end

  def and_click_to_remove_a_skill
    @skill = @skills.last
    accept_confirm do
      find(:css, "a[href='/admin/skills/#{@skill.id}'][data-method='delete']").click
    end
  end

  def then_i_should_see_skill_was_successfully_deleted
    expect(page).to have_content("Skill was successfully deleted.")
    expect(Skill.all).to_not include(@skill)
  end
end