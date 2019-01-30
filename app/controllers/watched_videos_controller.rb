class WatchedVideosController < ApplicationController
  # calls index view and displays a list of all watched
  # videos that have been recorded
  def index
    @watched_videos = WatchedVideo.all
  end
end
