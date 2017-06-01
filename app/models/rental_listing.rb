class RentalListing < ApplicationRecord

  def full_address
    [address, street, unit, city, state, zip].compact.join(',')
  end
  
  geocoded_by :full_address

  after_validation :geocode, if: ->(obj){ obj.full_address.present? and obj.address_changed? } 

  has_one :rental_image, dependent: :destroy
  has_many :rental_favorites, dependent: :destroy

  acts_as_mappable :lat_column_name => :latitude, :lng_column_name => :longitude

end
