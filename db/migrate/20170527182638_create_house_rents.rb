class CreateHouseRents < ActiveRecord::Migration[5.1]
  def change
    create_table :house_rents do |t|
      t.integer :addr
      t.string :street
      t.string :unit
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :bed
      t.integer :bath
      t.integer :sq_ft
      t.integer :price
      t.string :type

      t.timestamps
    end
  end
end
