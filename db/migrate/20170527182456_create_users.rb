class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :addr
      t.string :first_name
      t.string :last_name
      t.integer :phone
      t.string :type

      t.timestamps
    end
  end
end
