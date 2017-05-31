class RentalImage < ApplicationRecord
  belongs_to :rental_listing
  
  mount_uploaders :gallery, RentalImageUploader
end
