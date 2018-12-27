class CreateWatchedVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :watched_videos do |t|
      t.string :title
      t.datetime :date_viewed
      t.string :link

      t.timestamps
    end
  end
end
