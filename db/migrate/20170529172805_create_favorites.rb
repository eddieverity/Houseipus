class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.string :context
      t.references :sale_listing, foreign_key: true
      t.references :rental_listing, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
