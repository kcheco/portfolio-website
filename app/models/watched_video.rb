class WatchedVideo < ApplicationRecord
  # validation rules
  validates_presence_of   :title
  validates_presence_of   :date_viewed
  validates_presence_of   :link
  validates_format_of     :link, :with => URI::regexp(%w(http https))
end
