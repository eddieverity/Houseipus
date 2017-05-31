class Image < ApplicationRecord
  belongs_to :sale_listing
  belongs_to :rental_listing

  mount_uploaders :gallery, ListingPhotoUploader
  mount_uploader :context, ListingPhotoUploader

end
