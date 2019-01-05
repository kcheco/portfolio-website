class Image < ApplicationRecord
  # validation rules
  validates  :source, presence: true,
                      url: true

  # relationships
  belongs_to :coverable, polymorphic: true, optional: true
end
