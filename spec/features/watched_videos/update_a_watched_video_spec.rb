require 'rails_helper'

feature "Updating a watched video" do
  background do
    given_i_have_details_of_a_video_i_want_to_change
  end

  scenario "I am able to successfully make changes to a video I saved as watched" do
    when_i_click_on_the_video_i_want_to_edit
    and_i_set_a_different_date
    and_i_click_the_update_button
    then_i_should_see_i_successfully_updated_the_watched_video
  end

  scenario "I am able to successfully change to cover of the book" do
    when_i_click_on_the_video_i_want_to_edit
    and_i_change_the_cover_of_the_video
    and_i_click_the_update_button
    then_i_should_see_i_successfully_updated_the_watched_video
    and_i_should_see_the_updated_cover
  end

  private
  def given_i_have_details_of_a_video_i_want_to_change
    @watched_video = FactoryBot.create(:watched_video, :with_cover)
  end

  def when_i_click_on_the_video_i_want_to_edit
    visit "/admin/watched_videos"
    has_content?("#{@watched_video.title}")
    find(:css, "a[href='/admin/watched_videos/#{@watched_video.id}/edit']").click
  end

  def and_i_set_a_different_date
    fill_in "Date Viewed", :with => "2018/12/21"
  end

  def and_i_change_the_cover_of_the_video
    fill_in "Cover", :with => "https://examplevideo.com/updated_cover.jpg"
  end

  def and_i_click_the_update_button
    # close datepicker
    find('#watched_video_date_viewed').click
    find('.ui-datepicker-close').click
    click_button 'Apply Changes'
  end

  def then_i_should_see_i_successfully_updated_the_watched_video
    expect(page).to have_content('Video was successfully updated.')
  end

  def and_i_should_see_the_updated_cover
    expect(page).to have_css("img[src='https://examplevideo.com/updated_cover.jpg']")
  end
end
