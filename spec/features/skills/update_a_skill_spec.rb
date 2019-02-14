require 'rails_helper'

feature 'Update a skill' do
  background do
    given_i_have_a_set_of_skills
    and_i_am_signed_in_as_an_admin
  end

  scenario 'as an admin allows me to change the name' do
    when_i_visit_the_skills_page
    and_i_click_on_the_skill_i_want_to_edit
    and_i_set_another_skill_name
    and_click_the_update_button
    then_i_should_see_i_succesfully_updated_the_skill
  end

  scenario 'as an admin allows me to reorder the list of skills' do
    when_i_visit_the_skills_page
    and_i_drag_skill1_under_skill2
    then_i_should_see_the_skill2_comes_before_skill1
  end

  private
  def given_i_have_a_set_of_skills
    @skill1 = Skill.create(name: "Javascript")
    @skill2 = Skill.create(name: "NodeJS")
    @skill3 = Skill.create(name: "Ruby on Rails")
  end

  def and_i_am_signed_in_as_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
      password: 'testpw123'})
    sign_in @user
  end

  def when_i_visit_the_skills_page
    visit '/'
    click_link 'Skills'
    page.has_content?("#{@skill1.name}")
    page.has_content?("#{@skill2.name}")
    page.has_content?("#{@skill3.name}")
  end
  
  def and_i_click_on_the_skill_i_want_to_edit
    find(:css, "a[href='/admin/skills/#{@skill1.id}/edit']").click
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

  def and_i_drag_skill1_under_skill2
    # fix due to capybara drag_to method does not work
    # starting_point = all('.skill-item').first
    # target_point = all('.skill-item').last
    # starting_point.drag_to target_point
    page.execute_script %{
      var elementToMove = $('.skill-item:first');
      var target = $('.skill-item:last');
      elementToMove.simulateDragSortable({dropOn: target});
    }
    sleep 0.4
  end

  def then_i_should_see_the_skill2_comes_before_skill1
    within all('.skill-item').first do
      expect(page).to have_content("#{@skill2.name}")
    end
  end
end