require 'rails_helper'

feature 'Signing up a user' do
  scenario 'with valid credentials is successful' do
    when_i_visit_the_sign_up_page
    and_i_set_the_email_for_account
    and_i_set_the_password_for_account
    and_i_click_the_sign_up_button
    then_i_should_sign_up_successfully
  end

  scenario 'with invalid credentials fail' do
    when_i_visit_the_sign_up_page
    and_i_set_an_invalid_email
    and_i_set_an_invalid_password
    and_i_click_the_sign_up_button
    then_i_should_see_form_errors
  end

  private
  def when_i_visit_the_sign_up_page
    visit 'users/sign_up'
  end

  def and_i_set_the_email_for_account
    fill_in "Email", :with => "user@testemail.com"
  end

  def and_i_set_the_password_for_account
    fill_in "Password", :with => "password"
  end

  def and_i_click_the_sign_up_button
    click_button "Sign up"
  end
  
  def then_i_should_sign_up_successfully
    expect(page).to have_content("You have signed up successfully.")
  end

  def and_i_set_an_invalid_email
    fill_in "Email", :with => ""
  end

  def and_i_set_an_invalid_password
    fill_in "Password", :with => ''
  end

  def then_i_should_see_form_errors
    expect(page).to have_content("There was an error.")
  end
end