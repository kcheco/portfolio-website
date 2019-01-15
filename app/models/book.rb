class Book < ApplicationRecord
  include Coverable

  #validation rules
  validates_presence_of   :title, :date_read
  validates_presence_of   :image, message: 'Hey, quit being lazy and add the cover of this book!'
end
