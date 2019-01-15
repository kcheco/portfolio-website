class Project < ApplicationRecord
  include Coverable

  # validation rules
  validates_presence_of   :name
  validates_presence_of   :date_completed
  validates_presence_of   :image, message: 'The cover of this project was not added.'
  validates               :link, presence: true, url: true
end
