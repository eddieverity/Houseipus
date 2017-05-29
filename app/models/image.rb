class Image < ApplicationRecord
  belongs_to :sale_listing
  belongs_to :rental_listing
end
