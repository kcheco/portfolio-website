class PagesController < ApplicationController
  def home
    @projects = Project.latest
    @books = Book.last_read
    @watched_videos = WatchedVideo.last_viewed
    @skills = Skill.by_orderno
  end
end
