class WatchedVideo < ApplicationRecord
  include Coverable

  # validation rules
  validates_presence_of   :title
  validates_presence_of   :date_viewed
  validates               :link, presence: true,
                                 url: true
  validates_presence_of   :image, message: "Hey, the cover of this video you watched isn't going to add itself!"
end
