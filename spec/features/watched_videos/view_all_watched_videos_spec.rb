require 'rails_helper'

feature "Viewing all the wathced videos" do
  scenario "I am able ot view all dev-related youtube videos I've watched" do
    given_i_have_a_list_of_videos_i_recorded_as_watched
    when_i_visit_the_watched_videos_page
    then_i_should_see_a_list_of_watched_videos
  end

  private
  def given_i_have_a_list_of_videos_i_recorded_as_watched
    @watched_videos = FactoryBot.create_list(:watched_video, 5, :with_cover)
  end

  def when_i_visit_the_watched_videos_page
    visit '/watched_videos'
  end

  def then_i_should_see_a_list_of_watched_videos
    @watched_videos.each do |v|
      expect(page).to have_content("#{v.title}")
    end
  end
end
