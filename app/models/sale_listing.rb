class SaleListing < ApplicationRecord


    def full_address
        [address, street, unit, city, state, zip].compact.join(',')
    end

    geocoded_by :full_address
    acts_as_mappable

    after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

end
