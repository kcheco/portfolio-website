require 'rails_helper'

feature "View home page" do
  scenario do
    visit '/'
    expect(page).to have_content("Kelvin Checo")
  end
end
