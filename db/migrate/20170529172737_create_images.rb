class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :context
      t.references :sale_listing, foreign_key: true, default: nil
      t.timestamps
    end
  end
end
