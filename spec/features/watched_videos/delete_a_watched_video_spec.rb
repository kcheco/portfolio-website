require 'rails_helper'

feature "Deleting a watched video" do
  background do
    given_i_have_a_video_i_no_longer_want_on_my_list
  end

  scenario "I am able to successfully delete a video I recorded as watched" do
    when_i_see_the_video_i_want_to_delete_on_the_watched_videos_page
    and_i_click_the_delete_button
    then_i_was_successfully_able_to_delete_the_video_from_list
    and_i_should_no_longer_see_the_video_i_removed
  end

  private
  def given_i_have_a_video_i_no_longer_want_on_my_list
    @watched_videos_list = FactoryBot.create_list(:watched_video, 5, :with_cover)
    @watched_video = @watched_videos_list.first
  end

  def when_i_see_the_video_i_want_to_delete_on_the_watched_videos_page
    visit '/watched_videos'
  end

  def and_i_click_the_delete_button
    accept_confirm do
      find(:css, "a[href='/watched_videos/#{@watched_video.id}']").click
    end
  end

  def then_i_was_successfully_able_to_delete_the_video_from_list
    expect(page).to have_content("Video was successfully deleted.")
  end

  def and_i_should_no_longer_see_the_video_i_removed
    expect(page).to_not have_content("#{@watched_video.title}")
  end
end
