class Book < ApplicationRecord
  #validation rules
  validates_presence_of   :title, :date_read
end
