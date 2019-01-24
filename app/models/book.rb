class Book < ApplicationRecord
  include Coverable

  #validation rules
  validates_presence_of   :title, :date_read
  validates               :link, presence: true,
                                 url: true
  validates_presence_of   :image, message: 'Hey, quit being lazy and add the cover of this book!'

  # scopes
  def self.last_read
    order(date_read: :desc)
  end
end
