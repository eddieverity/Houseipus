class RentalListing < ApplicationRecord
  geocoded_by :address
  after_validation :geocode
  acts_as_mappable
end
