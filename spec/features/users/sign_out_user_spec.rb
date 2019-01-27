require 'rails_helper'

feature 'Sign out user' do
  background do
    given_i_have_succesfully_signed_in
  end

  scenario do
    when_i_visit_the_home_page
    and_i_click_the_logout_button
    then_i_should_see_i_successfully_logged_out
  end

  private
  def given_i_have_succesfully_signed_in
    @user = User.create({email: 'checokelvin@gmail.com', 
                            password: 'testpw123'})
    sign_in @user
  end

  def when_i_visit_the_home_page
    visit '/'
  end

  def and_i_click_the_logout_button
    click_link "Logout"
  end

  def then_i_should_see_i_successfully_logged_out
    expect(page).to have_content("Signed out successfully.")
  end
end