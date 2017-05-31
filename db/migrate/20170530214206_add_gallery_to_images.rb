class AddGalleryToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :gallery, :json
  end
end
