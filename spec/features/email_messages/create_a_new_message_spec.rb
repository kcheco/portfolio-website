require 'rails_helper'

feature 'Create a new email message' do
  scenario 'sends successfully with valid parameters' do
    when_i_visit_the_contact_page
    and_i_provide_my_name
    and_i_provide_my_email
    and_i_provide_my_number
    and_i_choose_to_provide_feedback
    and_i_type_my_feedback
    and_i_send_the_message
    then_i_should_see_message_was_successfully_sent
  end

  scenario 'with valid parameters provides me with feedback' do
    when_i_visit_the_contact_page
    and_i_provide_my_name
    and_i_provide_a_bad_email
    and_i_provide_i_missed_a_digit_on_my_number
    and_i_choose_to_provide_feedback
    and_i_type_my_feedback
    and_i_send_the_message
    then_i_should_see_the_errors
  end

  private
  def when_i_visit_the_contact_page
    visit '/'
    click_link "Contact Me"
  end
  
  def and_i_provide_my_name
    fill_in "Your name", with: "Kelvin Checo"
  end

  def and_i_provide_my_email
    fill_in "Email", with: "checokelvin@gmail.com"
  end

  def and_i_provide_a_bad_email
    fill_in "Email",	with: "test@email" 
  end

  def and_i_provide_my_number
    fill_in "Contact number", with: "3475555555"
  end

  def and_i_provide_i_missed_a_digit_on_my_number
    fill_in "Contact number",	with: "347555555" 
  end

  def and_i_choose_to_provide_feedback
    select "Provide Feedback", from: "Reason for contacting me"
  end

  def and_i_type_my_feedback
    fill_in "Additional information", with: "Your website is so fresh and so clean."
  end

  def and_i_send_the_message
    click_button "Send"
  end

  def then_i_should_see_message_was_successfully_sent
    expect(page).to have_content("Your message was successfully sent.")
  end

  def then_i_should_see_the_errors
    expect(page).to have_content("There was an error")
    expect(page).to have_content("Email is not valid")
    expect(page).to have_content("Phone must have at least 10 digits")
  end
end