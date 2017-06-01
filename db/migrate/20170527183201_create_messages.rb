class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :title
      t.text :content
      t.references :sender
      t.references :receiver
      t.boolean :viewed

      t.timestamps
    end
    add_foreign_key(:messages, :users, column: :sender_id)
    add_foreign_key(:messages, :users, column: :receiver_id)
  end
end
