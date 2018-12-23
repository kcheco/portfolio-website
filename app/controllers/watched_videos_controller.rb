class WatchedVideosController < ApplicationController
  # calls index view and displays a list of all watched
  # videos that have been recorded
  def index
    @watched_videos = WatchedVideo.all
  end

  # calls view to be rendered for user to add a youtube 
  # video they've watched
  def new
    @watched_video = WatchedVideo.new
  end

  # ingests valid parameters and adds a new watched video
  def create
    @watched_video = WatchedVideo.new(watched_video_params)

    respond_to do |format|
      if @watched_video.save
        format.html { redirect_to edit_watched_video_path(@watched_video), 
                      notice: "Video was successfully added." }
      else
        format.html { render :new }
      end
    end
  end

  # calls view to be rendered for user to edit the details
  # of a watched video
  def edit
    @watched_video = WatchedVideo.find(params[:id])
  end

  # ingests valid parametes and applies changes to exisiting watched
  # video
  def update
    @watched_video = WatchedVideo.find(params[:id])

    respond_to do |format|
      if @watched_video.update(watched_video_params)
        format.html { redirect_to edit_watched_video_path(@watched_video), 
                      notice: "Video was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  private
  # specifies valid parameters that may be ingested by the
  # watched video resource
  def watched_video_params
    params.require(:watched_video)
          .permit(:title,
                  :date_viewed,
                  :link)
  end
end
