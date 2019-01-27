require 'rails_helper'

feature 'Sign in user' do
  background do
    given_i_have_already_signed_up_as_a_user
  end

  scenario 'with valid credentials is successful' do
    when_i_visit_the_login_page
    and_i_set_my_email
    and_i_set_my_password
    and_i_click_the_login_button
    then_i_should_see_i_successfully_signed_in
    and_i_should_see_logout_button
  end

  scenario 'with invalid credentials provides feedback' do
    when_i_visit_the_login_page
    and_i_set_my_email
    and_i_click_the_login_button
    then_i_should_see_i_provided_invalid_credentials
  end

  private
  def given_i_have_already_signed_up_as_a_user
    @user = User.create({email: 'checokelvin@gmail.com', 
                            password: 'testpw123'})
  end

  def when_i_visit_the_login_page
    visit '/admin/login'
  end

  def and_i_set_my_email
    fill_in "Email", :with => 'checokelvin@gmail.com'
  end

  def and_i_set_my_password
    fill_in "Password", :with => 'testpw123'
  end

  def and_i_click_the_login_button
    click_button "Log in"
  end

  def then_i_should_see_i_successfully_signed_in
    expect(page).to have_content("You have signed in successfully.")
  end

  def then_i_should_see_i_provided_invalid_credentials
    expect(page).to have_content("Invalid email or password.")
  end

  def and_i_should_see_logout_button
    expect(page).to have_content("Logout")
  end
end