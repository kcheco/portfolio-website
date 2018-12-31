require 'rails_helper'

feature "Creating a watched video" do
  scenario "I am able to successfully add a dev-related youtube video I watched" do
    when_i_want_to_add_a_video_i_watched
    and_i_set_the_title
    and_i_set_the_date_i_watched_the_video
    and_i_set_the_link
    and_i_click_the_create_button
    then_i_should_see_the_watched_video_added_successfully
  end

  private
  def when_i_want_to_add_a_video_i_watched
    visit '/watched_videos/new'
  end

  def and_i_set_the_title
    fill_in "Title", :with => "20180726 Laracon 2018 Bob Martin"
  end

  def and_i_set_the_date_i_watched_the_video
    fill_in "Date Viewed", :with => "2018/12/19"
  end

  def and_i_set_the_link
    fill_in "Link", :with => "https://youtu.be/NeXQEJNWO5w"
  end

  def and_i_click_the_create_button
    click_button "Add Video"
  end

  def then_i_should_see_the_watched_video_added_successfully
    expect(page).to have_content("Video was successfully added.")
  end
end