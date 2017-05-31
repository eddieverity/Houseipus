class CreateRentalFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :rental_favorites do |t|
      t.references :rental_listing, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
