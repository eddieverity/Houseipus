class CreateSavedSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_searches do |t|
      t.references :user, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
