class CreateRentalImages < ActiveRecord::Migration[5.1]
  def change
    create_table :rental_images do |t|
      t.references :rental_listing, foreign_key: true
      t.json :gallery

      t.timestamps
    end
  end
end
