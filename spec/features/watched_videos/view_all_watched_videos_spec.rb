require 'rails_helper'

feature "Viewing all the wathced videos" do
  background do
    given_i_have_a_list_of_videos_i_recorded_as_watched
  end

  scenario "I am able to view all dev-related youtube videos I've watched" do
    when_i_visit_the_watched_videos_page
    then_i_should_see_a_list_of_watched_videos
    and_i_should_not_see_the_add_new_button
  end

  scenario "as an admin I am able to view all dev-related youtube videos" do
    given_i_am_an_admin
    and_i_sign_in
    when_i_visit_the_watched_videos_page
    then_i_should_see_a_list_of_watched_videos
    and_i_should_see_the_add_new_button
  end

  private
  def given_i_have_a_list_of_videos_i_recorded_as_watched
    @watched_videos = FactoryBot.create_list(:watched_video, 5, :with_cover)
  end

  def given_i_am_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  def and_i_sign_in
    sign_in @user
  end

  def when_i_visit_the_watched_videos_page
    visit '/watched_videos'
  end

  def then_i_should_see_a_list_of_watched_videos
    @watched_videos.each do |v|
      expect(page).to have_content("#{v.title}")
    end
  end

  def and_i_should_not_see_the_add_new_button
    expect(page).to_not have_css("a[href='/admin/watched_videos/new']")
  end

  def and_i_should_see_the_add_new_button
    expect(page).to have_css("a[href='/admin/watched_videos/new']")
  end
end
