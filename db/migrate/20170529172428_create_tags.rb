class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.references :sale_listing, foreign_key: true
      t.references :rental_listing, foreign_key: true
      t.string :context

      t.timestamps
    end
  end
end
