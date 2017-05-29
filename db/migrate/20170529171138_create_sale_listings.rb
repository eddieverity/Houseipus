class CreateSaleListings < ActiveRecord::Migration[5.1]
  def change
    create_table :sale_listings do |t|
      t.integer :address
      t.string :street
      t.string :unit
      t.string :city
      t.string :state
      t.string :zip
      t.integer :bed
      t.integer :bath
      t.integer :footage
      t.integer :price
      t.string :type
      t.text :description
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
