class AddUserToRentalListing < ActiveRecord::Migration[5.1]
  def change
    add_reference :rental_listings, :user, foreign_key: true
  end
end
