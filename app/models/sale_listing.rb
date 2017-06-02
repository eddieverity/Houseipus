class SaleListing < ApplicationRecord

    def full_address
        [address, street, unit, city, state, zip].compact.join(',')
    end

    geocoded_by :full_address
    reverse_geocoded_by :latitude, :longitude

    validates :user, presence: true

    has_one :image, dependent: :destroy
    has_many :favorites, dependent: :destroy

    after_validation :geocode, if: ->(obj){ obj.full_address.present? and obj.address_changed? }

    acts_as_mappable :lat_column_name => :latitude, :lng_column_name => :longitude

end
