class RentalFavorite < ApplicationRecord
  belongs_to :rental_listing
  belongs_to :user
end
