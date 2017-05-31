class Image < ApplicationRecord
  belongs_to :sale_listing

  mount_uploaders :gallery, ListingPhotoUploader

end
