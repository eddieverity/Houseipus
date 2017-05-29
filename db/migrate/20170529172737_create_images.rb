class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :context
      t.references :sale_listing, foreign_key: true
      t.references :rental_listing, foreign_key: true

      t.timestamps
    end
  end
end
