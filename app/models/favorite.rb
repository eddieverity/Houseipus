class Favorite < ApplicationRecord
  belongs_to :sale_listing
  belongs_to :rental_listing
  belongs_to :user
end
