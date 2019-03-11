require 'rails_helper'

feature "View home page" do
  background do
    given_i_have_a_list_of_projects
    and_i_have_a_list_of_books_ive_read
    and_i_have_a_list_of_dev_videos_ive_watched
    and_i_have_list_of_skills
  end

  scenario 'not as an admin does not show admin nav' do
    when_i_visit_the_home_page
    then_i_should_see_the_heading_of_each_section
    and_i_should_see_the_three_most_recent_projects
    and_i_should_see_the_three_most_recent_books_ive_read
    and_i_should_see_the_three_most_recent_dev_videos_ive_watched
    and_i_should_see_all_the_skills_i_have
    and_i_should_not_see_admin_navbar
    and_i_should_see_a_navbar_as_the_footer
    and_i_should_not_see_edit_delete_buttons_for_all_resources
  end

  scenario 'as an admin allows for editing content' do
    given_i_am_an_admin
    and_i_have_signed_in
    when_i_visit_the_home_page
    then_i_should_see_the_heading_of_each_section
    and_i_should_see_the_three_most_recent_projects
    and_i_should_see_the_three_most_recent_books_ive_read
    and_i_should_see_the_three_most_recent_dev_videos_ive_watched
    and_i_should_see_all_the_skills_i_have
    and_i_should_not_see_a_navbar_as_the_footer
    and_i_should_see_admin_navbar
    and_i_should_see_edit_delete_buttons_for_all_resources
  end

  private
  def given_i_am_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  def and_i_have_signed_in
    sign_in @user
  end

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

  def and_i_have_list_of_skills
    @skills = FactoryBot.create_list(:skill, 5)
  end

  def when_i_visit_the_home_page
    visit '/'
  end

  def then_i_should_see_the_heading_of_each_section
    expect(page).to have_content("I'm a fullstack engineer")
    expect(page).to have_content("How I started programming")
    expect(page).to have_content("Projects")
    expect(page).to have_content("Books I've Read")
    expect(page).to have_content("Videos I've recently watched")
    expect(page).to have_content("Skills")
  end

  def and_i_should_see_the_three_most_recent_projects
    expect(page).to have_css("img[src='#{@project4.image.source}']")
    expect(page).to have_css("img[src='#{@project3.image.source}']")
    expect(page).to have_css("img[src='#{@project2.image.source}']")
    expect(page).to_not have_content("#{@project1.name}")
  end

  def and_i_should_see_the_three_most_recent_books_ive_read
    expect(page).to have_css("img[src='#{@book4.image.source}']")
    expect(page).to have_css("img[src='#{@book3.image.source}']")
    expect(page).to have_css("img[src='#{@book2.image.source}']")
    expect(page).to_not have_content("#{@book1.title}")
  end

  def and_i_should_see_the_three_most_recent_dev_videos_ive_watched
    expect(page).to have_css("img[src='#{@watched_video4.image.source}']")
    expect(page).to have_css("img[src='#{@watched_video3.image.source}']")
    expect(page).to have_css("img[src='#{@watched_video2.image.source}']")
    expect(page).to_not have_content("#{@watched_video1.title}")
  end

  def and_i_should_see_all_the_skills_i_have
    @skills.each do |skill|
      expect(page).to have_content("#{skill.name.gsub(/\s/, "-").downcase }")
    end
  end

  def and_i_should_see_a_navbar_as_the_footer
    expect(page).to have_selector(".footer-nav")
  end

  def and_i_should_not_see_a_navbar_as_the_footer
    expect(page).to_not have_selector(".footer-nav")
  end

  def and_i_should_see_admin_navbar
    expect(page).to have_selector(".navbar-nav")
    expect(page).to have_css("a[href='/admin/books']")
    expect(page).to have_css("a[href='/admin/watched_videos']")
    expect(page).to have_css("a[href='/admin/projects']")
  end

  def and_i_should_not_see_admin_navbar
    expect(page).to_not have_select(".navbar-nav")
    expect(page).to_not have_css("a[href='/admin/books']")
    expect(page).to_not have_css("a[href='/admin/watched_videos']")
    expect(page).to_not have_css("a[href='/admin/projects']")
  end

  def and_i_should_see_edit_delete_buttons_for_all_resources
    expect(page).to have_css("a[href='/admin/books/#{@book4.id}/edit']")
    expect(page).to have_css("a[href='/admin/books/#{@book4.id}'][data-method='delete']")
  end

  def and_i_should_not_see_edit_delete_buttons_for_all_resources
    expect(page).to_not have_css("a[href='/admin/books/#{@book4.id}/edit']")
    expect(page).to_not have_css("a[href='/admin/books/#{@book4.id}'][data-method='delete']")
  end
end
