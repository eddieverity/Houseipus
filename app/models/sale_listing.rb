class SaleListing < ApplicationRecord

    def full_address
        [address, street, unit, city, state, zip].compact.join(',')
    end

    geocoded_by :full_address
    reverse_geocoded_by :latitude, :longitude

    after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

    acts_as_mappable :lat_column_name => :latitude, :lng_column_name => :longitude

end
