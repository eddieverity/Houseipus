class AddUserToSaleListing < ActiveRecord::Migration[5.1]
  def change
    add_reference :sale_listings, :user, foreign_key: true
  end
end
