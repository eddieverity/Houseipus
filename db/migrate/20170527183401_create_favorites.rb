class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :house_rent, foreign_key: true
      t.references :house_sale, foreign_key: true

      t.timestamps
    end
  end
end
