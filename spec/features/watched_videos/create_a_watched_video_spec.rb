require 'rails_helper'

feature "Creating a watched video" do
  background do
    given_i_am_an_admin
    and_i_log_in
  end

  scenario "I am able to successfully add a dev-related youtube video I watched" do
    when_i_want_to_add_a_video_i_watched
    and_i_set_the_title
    and_i_set_the_date_i_watched_the_video
    and_i_set_the_link
    and_i_set_the_cover_of_the_video
    and_i_click_the_create_button
    then_i_should_see_the_watched_video_added_successfully
    and_i_should_see_the_cover_of_the_video
  end

  scenario "always needs a cover" do
    when_i_want_to_add_a_video_i_watched
    and_i_set_the_title
    and_i_set_the_date_i_watched_the_video
    and_i_set_the_link
    and_i_click_the_create_button
    then_i_should_receive_an_error_for_not_setting_a_cover
  end

  private
  def given_i_am_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  def and_i_log_in
    sign_in @user
  end

  def when_i_want_to_add_a_video_i_watched
    visit '/watched_videos'
    click_link "Add New Video"
  end

  def and_i_set_the_title
    fill_in "Title", :with => "20180726 Laracon 2018 Bob Martin"
  end

  def and_i_set_the_date_i_watched_the_video
    fill_in "Date Viewed", :with => "2018/12/19"
    # closes datepicker
    find('.ui-datepicker-close').click
  end

  def and_i_set_the_link
    fill_in "Link", :with => "https://youtu.be/NeXQEJNWO5w"
  end

  def and_i_set_the_cover_of_the_video
    fill_in "Cover", :with => "https://i.ytimg.com/vi/NeXQEJNWO5w/maxresdefault.jpg"
  end

  def and_i_click_the_create_button
    click_button "Add Video"
  end

  def then_i_should_see_the_watched_video_added_successfully
    expect(page).to have_content("Video was successfully added.")
  end

  def and_i_should_see_the_cover_of_the_video
    expect(page).to have_css("img[src='https://i.ytimg.com/vi/NeXQEJNWO5w/maxresdefault.jpg']")
  end

  def then_i_should_receive_an_error_for_not_setting_a_cover
    expect(page).to have_content("Hey, the cover of this video you watched isn't going to add itself!")
  end
end
