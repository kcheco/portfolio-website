class Image < ApplicationRecord
  # constants
  IMAGE_URI_REGEX = /\A(?:([^:\/?#]+):)?(?:\/\/([^\/?#]*))?([^?#]*\.(?:jpg|gif|png|jpeg|svg))(?:\?([^#]*))?(?:#(.*))?\z/

  # validation rules
  validates  :source, presence: true,
                      format: { with: IMAGE_URI_REGEX }

  # relationships
  belongs_to :coverable, polymorphic: true, optional: true
end
