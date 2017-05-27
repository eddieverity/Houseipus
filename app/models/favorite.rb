class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :house_rent
  belongs_to :house_sale
end
