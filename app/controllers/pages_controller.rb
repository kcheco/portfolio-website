class PagesController < ApplicationController
  def home
    @projects = Project.latest
    @books = Book.last_read
    @watched_videos = WatchedVideo.last_viewed
    @skills = Skill.all
  end
end
