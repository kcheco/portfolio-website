class Book < ApplicationRecord
  #validation rules
  validates_presence_of   :title, :date_read
  validates_presence_of   :image, message: 'Hey, quit being lazy and add the cover of this book!'

  # relationships
  has_one :image, as: :coverable, dependent: :destroy

  accepts_nested_attributes_for :image, allow_destroy: true, 
                                        reject_if: -> (attrs) { attrs['source'].blank? }

  # methods
  # a more readable method to build_association method
  def with_no_cover
    build_image
    self
  end

  # checks if association is set
  def has_image?
    !image.nil?
  end
end
