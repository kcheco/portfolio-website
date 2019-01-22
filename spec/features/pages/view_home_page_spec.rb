require 'rails_helper'

feature "View home page" do
  background do
    given_there_are_more_than_three_projects
  end

  scenario do
    when_i_visit_the_home_page
    then_i_should_see_the_heading_of_each_section
    and_i_should_see_the_three_most_recent_projects
  end

  private
  def given_there_are_more_than_three_projects
    @project1 = FactoryBot.create(:project, :with_cover, date_completed: 1.year.ago)
    @project2 = FactoryBot.create(:project, :with_cover, date_completed: 1.month.ago)
    @project3 = FactoryBot.create(:project, :with_cover, date_completed: 1.week.ago)
    @project4 = FactoryBot.create(:project, :with_cover, date_completed: 1.day.ago)
  end

  def when_i_visit_the_home_page
    visit '/'
  end

  def then_i_should_see_the_heading_of_each_section
    expect(page).to have_content("Kelvin Checo")
    expect(page).to have_content("About me")
    expect(page).to have_content("Projects")
  end

  def and_i_should_see_the_three_most_recent_projects
    expect(page).to have_css("img[src='#{@project4.image.source}']")
    expect(page).to have_css("img[src='#{@project3.image.source}']")
    expect(page).to have_css("img[src='#{@project2.image.source}']")
    expect(page).to_not have_css("img[src='#{@project1.image.source}']")
  end
end
