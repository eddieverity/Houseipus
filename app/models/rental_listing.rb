class RentalListing < ApplicationRecord

  def full_address
    [address, street, unit, city, state, zip].compact.join(',')
  end
  
  geocoded_by :address
  after_validation :geocode

  has_one :rentalimage, dependent: :destroy
  has_many :favorites, dependent: :destroy

  acts_as_mappable :lat_column_name => :latitude, :lng_column_name => :longitude

end
