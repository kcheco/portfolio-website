require 'rails_helper'

feature "Updating a watched video" do
  scenario "I am able to successfully make changes to a video I saved as watched" do
    given_i_have_details_of_a_video_i_want_to_change
    when_i_visit_the_edit_page
    and_i_set_a_different_date
    and_i_click_the_update_button
    then_i_should_see_i_successfully_updated_the_watched_video
  end

  private
  def given_i_have_details_of_a_video_i_want_to_change
    @watched_video = FactoryBot.create(:watched_video)
  end

  def when_i_visit_the_edit_page
    visit "/watched_videos/#{@watched_video.id}/edit"
  end

  def and_i_set_a_different_date
    fill_in "Date Viewed", :with => "2018/12/21"
  end

  def and_i_click_the_update_button
    click_button 'Apply Changes'
  end

  def then_i_should_see_i_successfully_updated_the_watched_video
    expect(page).to have_content('Video was successfully updated.')
  end
end
