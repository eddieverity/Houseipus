class RentalListing < ApplicationRecord

  def full_address
    [address, street, unit, city, state, zip].compact.join(',')
  end
  
  geocoded_by :address
  after_validation :geocode
  acts_as_mappable

end
