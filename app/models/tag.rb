class Tag < ApplicationRecord
  belongs_to :house_sale
  belongs_to :house_rent
end
