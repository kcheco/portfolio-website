class Project < ApplicationRecord
  # validation rules
  validates_presence_of   :name
  validates_presence_of   :date_completed
  validates               :link, presence: true, url: true
end
