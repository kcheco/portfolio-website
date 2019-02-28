require 'rails_helper'

feature 'View contact page' do
  scenario do
    when_i_visit_the_contact_page
    then_i_should_see_the_heading
    and_the_contact_form
  end

  private
  def when_i_visit_the_contact_page
    visit '/'
    click_link_or_button 'Contact Me'
  end

  def then_i_should_see_the_heading
    expect(page).to have_content("Have an idea? Have a thought?")
  end

  def and_the_contact_form
    expect(page).to have_css("form[method='post']")
  end
end