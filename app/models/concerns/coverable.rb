module Coverable
  extend ActiveSupport::Concern

  included do
    has_one :image, as: :coverable, dependent: :destroy

    accepts_nested_attributes_for :image, allow_destroy: true,
                                        reject_if: -> (attrs) { attrs['source'].blank? }
  end

  # class methods
  # build a new resource with an associated image
  def with_no_cover
    build_image
    self
  end

  # check if resource has an image by seeing if association is not nil
  def has_image?
    !image.nil?
  end
end
