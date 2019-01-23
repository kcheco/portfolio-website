require 'rails_helper'

feature "View home page" do
  background do
    given_i_have_a_list_of_projects
    and_i_have_a_list_of_books_ive_read
    and_i_have_a_list_of_dev_videos_ive_watched
  end

  scenario do
    when_i_visit_the_home_page
    then_i_should_see_the_heading_of_each_section
    and_i_should_see_the_three_most_recent_projects
    and_i_should_see_the_three_most_recent_books_ive_read
    and_i_should_see_the_three_most_recent_dev_videos_ive_watched
  end

  private
  def given_i_have_a_list_of_projects
    @project1 = FactoryBot.create(:project, :with_cover, date_completed: 1.year.ago)
    @project2 = FactoryBot.create(:project, :with_cover, date_completed: 1.month.ago)
    @project3 = FactoryBot.create(:project, :with_cover, date_completed: 1.week.ago)
    @project4 = FactoryBot.create(:project, :with_cover, date_completed: 1.day.ago)
  end

  def and_i_have_a_list_of_books_ive_read
    @book1 = FactoryBot.create(:book, :with_cover, date_read: 1.year.ago)
    @book2 = FactoryBot.create(:book, :with_cover, date_read: 1.month.ago)
    @book3 = FactoryBot.create(:book, :with_cover, date_read: 1.week.ago)
    @book4 = FactoryBot.create(:book, :with_cover, date_read: 1.day.ago)
  end

  def and_i_have_a_list_of_dev_videos_ive_watched
    @watched_video1 = FactoryBot.create(:watched_video, :with_cover, date_viewed: 1.year.ago)
    @watched_video2 = FactoryBot.create(:watched_video, :with_cover, date_viewed: 1.month.ago)
    @watched_video3 = FactoryBot.create(:watched_video, :with_cover, date_viewed: 1.week.ago)
    @watched_video4 = FactoryBot.create(:watched_video, :with_cover, date_viewed: 1.day.ago)
  end

  def when_i_visit_the_home_page
    visit '/'
  end

  def then_i_should_see_the_heading_of_each_section
    expect(page).to have_content("Kelvin Checo")
    expect(page).to have_content("About me")
    expect(page).to have_content("Projects")
    expect(page).to have_content("Books I've Read")
    expect(page).to have_content("Videos I've recently watched")
  end

  def and_i_should_see_the_three_most_recent_projects
    expect(page).to have_css("img[src='#{@project4.image.source}']")
    expect(page).to have_css("img[src='#{@project3.image.source}']")
    expect(page).to have_css("img[src='#{@project2.image.source}']")
    expect(page).to_not have_css("img[src='#{@project1.image.source}']")
  end

  def and_i_should_see_the_three_most_recent_books_ive_read
    expect(page).to have_css("img[src='#{@book4.image.source}']")
    expect(page).to have_css("img[src='#{@book3.image.source}']")
    expect(page).to have_css("img[src='#{@book2.image.source}']")
    expect(page).to_not have_css("img[src='#{@book1.image.source}']")
  end

  def and_i_should_see_the_three_most_recent_dev_videos_ive_watched
    expect(page).to have_css("img[src='#{@watched_video4.image.source}']")
    expect(page).to have_css("img[src='#{@watched_video3.image.source}']")
    expect(page).to have_css("img[src='#{@watched_video2.image.source}']")
    expect(page).to_not have_css("img[src='#{@watched_video1.image.source}']")
  end
end
